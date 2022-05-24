class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    #binding.pry
    user = User.new(user_params)
      if user.save && (params[:password]==params[:password_confirmation])
        flash[:success] = "Welcome, #{user.username}!"
        redirect_to "/users/#{user.id}"
      elsif !(params[:password]==params[:password_confirmation])
        redirect_to "/users/register"
        flash[:notice] = "Error: Passwords do not match"
      elsif params[:username].length == 0
        redirect_to "/users/register"
        flash[:notice] = "Error: Please Enter A Username"
      elsif params[:name].length == 0
        redirect_to "/users/register"
        flash[:notice] = "Error: Please Enter Your Name"
      else
        redirect_to "/users/register"
        flash[:notice] = "Error: User already exists with this email"

      end
  end

private
  def user_params
    params.permit(:name, :email, :username, :password)
  end

end
