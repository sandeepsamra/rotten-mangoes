class Admin::UsersController < ApplicationController

  # before_action :check_admin

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} has been saved as a user."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(admin_user_params)
      redirect_to admin_users_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user).deliver
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def admin_user_params
    params.require(:user).permit(
      :firstname, :lastname, :email, :password, :password_confirmation
    )
  end

  # def check_admin
  #   @admin ||= User.where(admin: true)
  # end

end