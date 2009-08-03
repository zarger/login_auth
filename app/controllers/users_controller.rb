class UsersController < ApplicationController
  before_filter :login_required, :only => [:homepage]
  
  def homepage
    @user = current_user
  end
  
  def register
    @user = User.new
  end

  def signin
    if request.post?
      self.current_user = User.authenticate(params[:email], params[:password])
      @user = current_user
      if logged_in?
        if params[:remember_me] == "1"
          current_user.remember_me unless current_user.remember_token?
          cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        end
        redirect_to "homepage"
        flash[:notice] = "Logged in successfully"
      else
        flash[:notice] = "Invalid credentials."
      end
    end
  end
  
  def signout
    
  end
  
  def edit
    
  end
  
  def create
    @user = User.new(params[:user])
    begin 
      if @user.save!
        flash[:notice] = "Register Successful!"
        redirect_to :action => "homepage"
      else
        flash[:notice] = "Register Failed!"
        render :action => "register"
      end   
    rescue
      flash[:notice] = $!.to_s
      render :action => "register"
    end
  end
  
  def show
    
  end
  
  #logoff
  def logoff
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:success] = "You have been logged out."
    redirect_to :action => "signin"
  end
  
end
