class FileUpload < ApplicationRecord
 
  belongs_to :user
  has_one_attached :file

  validates :title, presence: true
  validates :file, presence: true
  validate :file_type_validation
  validate :file_size_validation

  private 
  def file_type_validation
    return unless file.attached?

    allowed_types = %w[image/jpeg image/png ]
    unless allowed_types.include?(file.content_type)
      errors.add(:file, "must be a JPEG, PNG")
    end
  end

  def file_size_validation
    return unless file.attached?

    max_size_in_mb = 100 # Limit to 100MB
    if file.byte_size > max_size_in_mb.megabytes
      errors.add(:file, "size cannot exceed #{max_size_in_mb}MB")
    end
  end
end
