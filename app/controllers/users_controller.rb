class UsersController < ApplicationController
  def index
    # ユーザーの一覧画面になるのでモデルから全ての情報を取得したい
    @users = User.all
  end

  def show
    # 一人のユーザーの情報を取得し、@userに代入している
    # params[:id]はカーソルを合わせた時に出てくるusers/1といった各々のidを持ってきている
    @user = User.find(params[:id])
  end

  def edit
    # どのユーザーを編集するかの情報を取得したいので、showの@user同様。
    @user = User.find(params[:id])
  end

  def update
    # どのユーザーを更新するか（一人のユーザー）の情報を取得したいので、showの@user同様。
    @user = User.find(params[:id])
    # 上で引っ張ってきた@userのどのカラムをupdateするのか
    @user.update(user_params)
    # ユーザーが更新できたらユーザーの詳細画面へ遷移
    redirect_to user_path(@user)
  end

  private
    # params.require(モデル名).permit(更新するカラム)
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
end
