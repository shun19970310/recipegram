class ApplicationController < ActionController::Base
  # deviseは新規登録の初期ではemailとパスワードしか登録しないことになっているのでユーザーネームを追加したい
  # ユーザーのページにアクセスする前にconfigure_permitted_parametersを実行させる
  before_action :configure_permitted_parameters, if: :devise_controller?
  # サインアップの時にユーザーネームを許可する。
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
