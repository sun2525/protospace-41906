class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  # プロトタイプが削除された際に関連するコメントも削除したい場合、dependent: :destroyオプションを使います。

  # バリデーション
  validates :title, presence: true              # プロトタイプの名称が必須
  validates :catch_copy, presence: true         # キャッチコピーが必須
  validates :concept, presence: true            # コンセプトが必須
  validates :image, presence: true
  # 画像が添付されているかを検証↓ChatGPTによる回答
  # validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
