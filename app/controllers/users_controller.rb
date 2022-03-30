class UsersController < ApplicationController
  def index
    # ユーザーの一覧画面になるのでユーザーモデルから全ての情報を取得したい
    @users = User.all
  end

  def show
    # 一人のユーザーの情報を取得し、@userに代入している
    # params[:id]はカーソルを合わせた時に出てくるusers/1といった各々のidを持ってきている
    @user = User.find(params[:id])
  end

  def edit
  end
end
