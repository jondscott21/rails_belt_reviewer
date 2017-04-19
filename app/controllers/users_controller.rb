class UsersController < ApplicationController
  before_action :check_login, except: [:index, :create, :login]
  def index
  end
  def create
    user = User.new(register_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/events'
    else
      flash[:errors] = user.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def login
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/events'
    else
      flash[:log_errors] = 'Invalid login'
      redirect_back(fallback_location: :back)
    end
  end

  def show
    @user = User.find(params[:user_id])
  end
  def update
    user = User.find(params[:id])
    if user.update(update_params)
      redirect_back(fallback_location: :back)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def log_out
    session[:user_id] = nil
    redirect_to '/'
  end
  private
  def register_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
  end
  def update_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state)
  end
end
