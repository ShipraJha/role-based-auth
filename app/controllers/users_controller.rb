# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :check_super_admin
  before_action :set_user, only: [:edit, :update, :show]
  before_action :fetch_roles, only: [:new, :edit, :create, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def show;end

  private

  def check_super_admin
    unless @current_user&.super_admin?
      flash[:alert] = "You don't have permission to perform this action."
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def fetch_roles
    @roles = Role.all
  end

  def user_params
    params.require(:user).permit(:name, role_ids: [])
  end
end
