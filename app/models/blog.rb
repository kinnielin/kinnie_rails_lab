class Blog < ApplicationRecord
  belongs_to :user

  validates :title, presence: { message: "標題不可為空" }
  validates :content, presence: { message: "內容不可為空" }
  validates :user_id, numericality: { greater_than: 0, message: "需指定使用者" }
end
