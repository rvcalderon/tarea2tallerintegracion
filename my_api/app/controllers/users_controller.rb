class UsersController < ApplicationController

  def index
    @users = User.all
    message = {'usuarios' => @users, 'total' => @users.count}.to_json
    render json: message, status: :ok
  end

  def show
    render json: @user 
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    head :no_content
  end 

  def user_params
      params.require(:user).permit(:usuario, :nombre, :apellido, :twitter)
  end

end