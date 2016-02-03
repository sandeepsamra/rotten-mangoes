class Admin::UsersController < ApplicationController

  # before_action :check_admin

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

  private

  # def check_admin
  #   @admin ||= User.where(admin: true)
  # end

end