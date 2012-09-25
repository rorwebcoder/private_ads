class UserSessionsController < ApplicationController
		before_filter :require_no_user, :only => [:new, :create, :forgot_password]
  before_filter :require_user, :only => :destroy
  before_filter :validate_user, :only => [:reset_password, :reset_password_submit]
  #~ layout "before_login"
		
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])    
    if @user_session.save
      flash[:notice] = "Login successful!"
      #~ redirect_based_on_role account_url, @user_session.role_name
      redirect_to users_path
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    session[:client_profile] = nil
    session[:client_profile_id] = nil
    flash[:notice] = "Logout successful!"
    #~ redirect_back_or_default new_user_session_url
    redirect_to new_user_session_url
  end
  
  def forgot_password
    if request.post?
      user = User.find_by_email(params[:user_session][:email])
      if user
        user.send_forgot_password!
        flash[:success] = "A link to reset your password has been mailed to you."
      else
        flash[:notice] = "Email #{params[:user_session][:email]} wasn't found.  Perhaps you used a different one?  Or never registered or something?"
        render :action => :forgot_password
      end
    end
  end
  
  def reset_password
    
  end
  
  def reset_password_submit    
    @user.ignore_blank_passwords = false
    if @user.update_attributes(params[:user])
      @user.ignore_blank_passwords = true
      flash[:success] = "Successfully reset password."
      redirect_to data_collection_index_path
    else
      flash[:notice] = "There was a problem resetting your password."
      render :action => :reset_password
    end
  end  
  
  private
  def validate_user
    @user = User.find_by_perishable_token(params[:reset_password_code])
    if @user
      return true
    else
      flash[:notice] = "You have entered invalid url. Please use the form below to get correct reset password url."
      return redirect_to forgot_password_url
    end    
  end  
end