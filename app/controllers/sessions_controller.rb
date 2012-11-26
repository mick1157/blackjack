class SessionsController < ApplicationController

# skip before filter -- for login because this will cause an endless loop (we are not loop)
# this filter is defined in the application_controller.rb
  skip_before_filter :login_required


  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def index
  end
end
