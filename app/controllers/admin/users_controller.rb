class Admin::UsersController < ApplicationController

  # before_action :check_admin

  # def check_admin
  # end

  def index
    @users = User.all
  end

end