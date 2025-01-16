class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  private

  def configure_permitted_parameters
    # 新規登録時に許可するパラメータ
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])

    # 編集時に許可するパラメータ
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :occupation, :position])
  end

  # def after_sign_in_path_for(resource)
  #   root_path # ログイン後にリダイレクトする先を指定
  # end

  # def after_sign_out_path_for(resource)
  #   root_path # ログアウト後にリダイレクトする先を指定
  # end

  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   end
  # end
end