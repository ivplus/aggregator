# frozen_string_literal: true

##
# Background job to create a delta dump download for a resource (organization)
class GenerateDeltaDumpJob < ApplicationJob
  def self.enqueue_all
    Organization.find_each { |org| GenerateDeltaDumpJob.perform_later(org) }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def perform(organization)
    now = Time.zone.now
    full_dump = organization.default_stream.current_full_dump
    return unless full_dump

    from = full_dump.last_delta_dump_at
    uploads = organization.default_stream.uploads.where(updated_at: from...now)

    return unless uploads.any?

    delta_dump = full_dump.deltas.create(stream_id: full_dump.stream_id)

    writer = MarcRecordWriterService.new("#{organization.slug}-#{Time.zone.today}-delta")

    begin
      # run through the files to find out which records to output, delete, etc.
      hash = current_marc_records(uploads)

      uploads.each do |upload|
        upload.each_marc_record_metadata.each do |record|
          next unless hash.dig(record.marc001, 'file_id') == record.file_id

          if hash.dig(record.marc001, 'status') == 'delete'
            writer.write_delete(record)
          else
            writer.write_marc_record(record)
          end
        end
      end

      writer.finalize

      writer.files.each do |as, file|
        delta_dump.public_send(as).attach(io: File.open(file), filename: as)
      end

      delta_dump.save!
      full_dump.update(last_delta_dump_at: now)
    ensure
      writer.close
      writer.unlink
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  def current_marc_records(uploads)
    hash = {}

    uploads.each do |upload|
      upload.each_marc_record_metadata.each do |record|
        hash[record.marc001] = record.attributes.slice('file_id', 'status')
      end
    end

    hash
  end
end
