class UsersController < ApplicationController

  require 'json'
  

  def index
    @users = User.all
    message = {'usuarios' => @users, 'total' => @users.count}.to_json
    render json: message, status: :ok
  end

  def show
    
    if User.exists?(id:params[:id]) 
      @user = User.find(params[:id])  
      render json: @user
    else
      render json: {error: "Usuario no encontrado"}, status:404
    end
  end

  def create

    @body = JSON.parse request.body.read
    @keys = @body.keys

    if @keys.include?"id"
      render json: {error: "No se puede crear usuario con id"}, status: 400
    
    else
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    

    puts 'impresion:'
    puts @keys

    if User.exists?(id: params[:id]) 

      @user = User.find(params[:id])

      if @user.update(user_params)
        render json: @user, status: :ok
      else
        msg = {'error' => 'La modificación ha fallado'}.to_json
        render json: msg, status: :internal_server_error
      end
      
    else
      render json: {error: "Usuario no encontrado"}, status:404
    end
  end

  def destroy
    if User.exists?(id:params[:id]) 
      @user = User.find(params[:id])
      @user.destroy
    else
      render json: {error: "Usuario no encontrado"}, status:404
    end

    
  end 

  def user_params
      params.permit(:usuario, :nombre, :apellido, :twitter)
  end

  def set_user
     if User.exists?(id:params[:id])
       @user=User.find(params[:id])
    else
       @user = nil
    end
  end

end
