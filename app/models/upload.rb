class Upload < ActiveRecord::Base

  belongs_to :post

  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png", :url => "/uploads/:attachment/:id/:style_:filename"
  validates_attachment_content_type :upload, content_type: %w(image/jpeg image/jpg image/png)

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "thumbnail_url" => upload.url(:thumb),
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_destroy_path(self.post, self),
      "delete_type" => "DELETE" 
    }
  end
end
