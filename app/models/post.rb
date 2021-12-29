class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence:true
  validates :content, presence:true
  validates :likes_counter, presence:true
end
