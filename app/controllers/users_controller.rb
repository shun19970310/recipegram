class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
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
    if @user != current_user
      redirect_to users_path, alert: "不正なアクセスです"
    end
  end

  def update
    # どのユーザーを更新するか（一人のユーザー）の情報を取得したいので、showの@user同様。
    @user = User.find(params[:id])
    # 上で引っ張ってきた@userのどのカラムをupdateするのか
    if @user.update(user_params)
    # ユーザーが更新できたらユーザーの詳細画面へ遷移
     redirect_to user_path(@user), notice: "更新に成功しました"
    else
     render :edit
    end
  end

  private
    # params.require(モデル名).permit(更新するカラム)
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
end
