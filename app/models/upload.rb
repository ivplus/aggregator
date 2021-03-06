# frozen_string_literal: true

# :nodoc:
class Upload < ApplicationRecord
  has_paper_trail
  belongs_to :stream, touch: true
  has_one :organization, through: :stream
  has_many :marc_records, dependent: :delete_all
  has_many :marc_profiles, dependent: :delete_all
  belongs_to :user, optional: true
  belongs_to :allowlisted_jwts, optional: true
  validates :url, presence: true, if: proc { |upload| upload.files.blank? }
  validates :files, presence: true, if: proc { |upload| upload.url.blank? }
  validate :valid_url, if: proc { |upload| upload.url.present? }
  scope :active, -> { where(status: 'active') }
  scope :archived, -> { where(status: 'archived') }

  after_create :attach_file_from_url

  has_many_attached :files

  after_save_commit :perform_extract_marc_record_metadata_job
  after_save_commit :perform_extract_files_job, if: :active?

  def active?
    status == 'active'
  end

  def name
    super.presence || created_at&.iso8601
  end

  def archive
    update(status: 'archived')
    files.find_each(&:purge_later)
  end

  def each_marc_record_metadata(&block)
    return to_enum(:each_marc_record_metadata) unless block

    files.each do |file|
      service = MarcRecordService.new(file.blob)

      format = service.identify

      extract_marc_record_delete_metadata(file, &block) if format == :delete

      next if format == :unknown

      extract_marc_record_metadata(file, service, &block)
    rescue StandardError => e
      Honeybadger.notify(e)
    end
  end

  private

  def perform_extract_marc_record_metadata_job
    ExtractMarcRecordMetadataJob.perform_later(self)
  end

  def perform_extract_files_job
    ExtractFilesJob.perform_later(self)
  end

  def valid_url
    errors.add(:url, 'Unable to attach file from URL') unless URI.parse(url)&.host
  end

  def attach_file_from_url
    return if url.blank?

    AttachRemoteFileToUploadJob.perform_later(self)
  end

  def extract_marc_record_delete_metadata(file)
    return to_enum(:extract_marc_record_delete_metadata, file) unless block_given?

    file.blob.open do |tmpfile|
      tmpfile.each_line do |line|
        yield MarcRecord.new(
          marc001: line.strip,
          file: file,
          upload: self,
          status: 'delete'
        )
      end
    end
  end

  def extract_marc_record_metadata(file, service)
    return to_enum(:extract_marc_record_metadata, file, service) unless block_given?

    service.each_with_metadata do |record, metadata|
      out = MarcRecord.new(
        **metadata,
        marc001: record['001']&.value,
        file: file,
        marc: record,
        upload: self
      )

      out.checksum ||= Digest::MD5.hexdigest(record.to_xml.to_s)

      yield out
    end
  end
end
