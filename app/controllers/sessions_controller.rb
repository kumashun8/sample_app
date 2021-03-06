# frozen_string_literal: true

# ユーザーのセッション情報に関するコントローラー
class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        # ユーザーログイン後にユーザ情報のページにリダイレクトする
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        recdirect_back_or @user
      else
        flash[:warning] =
          'Account not activated. Check your email for the activation link.'
        redirect_to root_url
      end
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
