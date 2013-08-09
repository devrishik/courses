class UsersController < ApplicationController

	before_action :authenticate! , :except => [:new, :create]

  def new
  	@user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def index
	@subjects = User.find(current_user.id).subjects
  end

  def userIndex
  	if current_user.id.to_i == params[:id].to_i
		redirect_to root_path  		
  	else
		@subjects = User.find(params[:id]).subjects
		render 'index'  		
  	end
  end

  def remove
  	@attending = Attending.where(user_id: current_user.id, subject_id: params[:id])
  	puts "params : " + params.to_s
  	@attending.destroy_all
  	redirect_to root_path
  end

  private

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end
end
