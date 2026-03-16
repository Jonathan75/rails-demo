class Post < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map(&:strip).reject(&:blank?).map do |name|
      Tag.find_or_create_by(name: name.downcase)
    end
  end
end
