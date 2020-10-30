# frozen_string_literal: true

# :nodoc:
class Upload < ApplicationRecord
  has_paper_trail
  belongs_to :stream
  has_one :organization, through: :stream

  has_many_attached :files

  def name
    super.presence || created_at&.iso8601
  end
end
