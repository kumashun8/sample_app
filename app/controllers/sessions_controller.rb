class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザ情報のページにリダイレクトする
    else
      # エラーメッセージを作成する
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
  end
end