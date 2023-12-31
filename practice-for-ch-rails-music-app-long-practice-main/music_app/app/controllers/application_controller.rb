# CR(R)LLL - ApplicationController
    # current_user
    # require_logged_in
    # require_logged_out
    # login!(user)
    # logged_in?
    # logout



class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    # skip_before_action :verify_authenticity_token

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        session[:session_token] = user.reset_session_token! # reset and save a new session token to cookie at this stage to prevent data breach
    end

    def require_logged_in
        redirect_to session_url unless logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in? # user singular would need an "id" put in
    end

    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end

    

end
