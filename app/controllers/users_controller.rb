class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.to_displayable_list.join("\n")
  end

  def show
    render plain: User.find(params[:id]).to_displayable_string
  end

  def new
    render "new"
  end

  def create
    newUser = User.new(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], password: params[:password])
    if !newUser.save
      flash[:error] = newUser.errors.full_messages.join(', ')
      redirect_to new_user_path
    else
      session[:current_user_id] = newUser.id
      redirect_to "/"
    end
  end

  def login

    if (request.post?)
      user = User.find_by(email: params[:email])

      if (user && user.authenticate(params[:password]))
        redirect_to todos_path
      elsif
        render plain:"invalid password"
      end

    else

      render "login"

    end
  end
end
