class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_signed_in?
  # private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate!
    if !session[:user_id]
      redirect_to sign_up_path
    end
  end

  def user_signed_in?
  	if session[:user_id]
  		return true
  	else
  		return false
  	end
  end
end
