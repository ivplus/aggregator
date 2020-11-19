# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Upload, type: :model do
  subject(:upload) { FactoryBot.create(:upload, :binary_marc) }

  describe 'validations' do
    it 'validates that a URL or files are present' do
      expect do
        FactoryBot.create(:upload, files: [])
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Url can't be blank, Files can't be blank")
    end

    context 'with an invalid URL' do
      before { upload.update(url: 'not-a-good.url') }

      it { expect(upload).not_to be_valid }
      it { expect(upload.errors[:url]).to include 'Unable to attach file from URL' }
    end
  end

  describe '#name' do
    it 'has a default name' do
      expect(upload.name).to match(/^\d{4}-\d{2}-\d{2}/)
    end
  end

  describe '#archive' do
    it 'sets status to archived' do
      upload.archive
      expect(upload.status).to eq 'archived'
    end

    it 'enqueues purge_later for every file' do
      expect do
        upload.archive
      end.to have_enqueued_job(ActiveStorage::PurgeJob)
    end
  end

  describe '#url' do
    it 'submits a job to attach the file from the URL if a URL is provided' do
      expect do
        FactoryBot.create(:upload, files: [], url: 'http://example.com/12345.marc')
      end.to enqueue_job(AttachRemoteFileToUploadJob).exactly(1).times.with(described_class.last)
    end
  end
end
