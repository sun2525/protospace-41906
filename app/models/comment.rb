class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  # バリデーション
  validates :content, presence: true  # コメントが空で保存されないようにするバリデーション

end
