class Recipe < ApplicationRecord
  # アソシエーション：一人のユーザーに紐づく1対Nの関係
  belongs_to :user
  attachment :image
  # 空白の投稿を全て弾く
  with_options presence: true do
    validates :title
    validates :body
    validates :image
  end
end