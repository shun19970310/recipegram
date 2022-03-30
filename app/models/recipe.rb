class Recipe < ApplicationRecord
  # アソシエーション：一人のユーザーに紐づく1対Nの関係
  belongs_to :user
  attachment :image
end