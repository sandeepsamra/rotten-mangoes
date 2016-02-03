class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user).deliver
    @user.destroy
    redirect_to admin_users_path
  end

end