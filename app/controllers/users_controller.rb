class UsersController < ApplicationController
  def index
    # ユーザーの一覧画面になるのでユーザーモデルから全ての情報を取得したい
    @users = User.all
  end

  def show
  end

  def edit
  end
end
