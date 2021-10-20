class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render 'new'
  end

  def create
    user = User.find_by(email: params[:email])

    if (user && user.authenticate(params[:password]))
      session[:current_user_id] = user.id
      redirect_to "/"
    elsif
      flash[:error] = "email or password is incorrect. Please try again!"
      redirect_to signin_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
