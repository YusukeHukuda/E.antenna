class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # Postテーブルのcontentカラムを検索する
  def self.search(search)
    return Post.all unless search
    Post.where(['body LIKE(?) OR title LIKE(?)', "%#{search}%", "%#{search}%"])
  end
end