class UserController < ApplicationController

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users/new
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}", notice: "User created!"
    else
      render :new
    end
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET /login
  def login
    session[:user_id] = nil
  end

  # POST /login
  def post_login
    user = User.find_by_email(login_params[:email])
    if user and user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end
  # GET /logout
  def logout
    session[:user_id] = nil
    redirect_to '/'
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def login_params
    params.require(:user).permit(:email,:password)
  end
end
