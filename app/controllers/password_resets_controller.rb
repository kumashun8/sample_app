class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit; end

  private

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    redirect_to root_url
  end
end
