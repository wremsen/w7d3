class SessionsController < ApplicationController

    # before_action :require_logged_out, only: [:new, :create]
    # before_action :require_logged_in, only: [:destroy]

    # helper_method :logged_in?, :current_user
    def new
        @user = User.new 
        render :new
    end

    def create
        email = params[:user][:email]
        password = params[:user][:password]

        @user = User.find_by_credentials(email, password)

        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(email: email)
            flash.now[:errors] = ["Dammit"]
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
    
    
end
