class OrganizationsController < ApplicationController
  before_action :require_login
  def index
    @org = Organization.all
  end

  def show
    @org = Organization.find(params[:id])
  end

  def create
    @orgs = Organization.new(name:params[:name], description:params[:description], user:current_user)
    if @orgs.save
    redirect_to "/organizations"
    else
      flash[:errors] = @orgs.errors.full_messages 
      redirect_to "/organizations"
    end
  end

  def join
    @user = User.find(session[:user_id])
    @org = Organization.find(params[:id])
    @org.memberships += [@user]
    redirect_to "/organizations/#{@org.id}"

  end

  def leave
    @user = User.find(session[:user_id])
    @org = Organization.find(params[:id])
    if @org.memberships.exists?(@user.id)
      @org.memberships.delete(@user)
    end
    redirect_to "/organizations/#{@org.id}"
  end

  def logout
    session[:user_id] = nil
    redirect_to "/users"
  end
end
