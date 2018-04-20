class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]
  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to "/organizations"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users"
    end
  end

  def login
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to "/organizations"
    else
      flash[:errors] = ["Invalid Username or Password"]
      redirect_to "/users"
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
