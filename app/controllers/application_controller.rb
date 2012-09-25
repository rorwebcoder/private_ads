class ApplicationController < ActionController::Base
  protect_from_forgery
  # Moved this to config/application.rb
  helper_method :current_user_session, :current_user
  
  def require_user
    return true if current_user
    # Login page
    redirect_to root_url
  end  
  
  def require_no_user
    return true if !current_user
    redirect_to users_path
  end  
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
end
