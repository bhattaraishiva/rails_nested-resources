class Comment < ApplicationRecord
  validates :commenter, presence: true
  validates :body, presence: true

  belongs_to :post
end
