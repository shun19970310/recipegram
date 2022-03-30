class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # refileをインストールしたことで使えるメソッド、image_idのidは書かない！
  attachment :profile_image
  # アソシエーション：一ユーザーにたくさんのrecipesが紐づく、dependent: :destroyはユーザーが削除されたら紐づいているrecipesも削除
  has_many :recipes,dependent: :destroy

end
