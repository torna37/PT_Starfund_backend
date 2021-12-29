class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence:true
  validates :likes_counter, presence:true
end
