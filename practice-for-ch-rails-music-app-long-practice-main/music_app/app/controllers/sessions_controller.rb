class SessionsController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]

    helper_method :logged_in?, :current_user
    def create
        email = params[:user][:email]
        password = params[:user][:password]

        @user = User.find_by_credentials(email, password)

        if @user.save
            redirect_to user_url
        else
            render json: errors.full_messages, status: 422
        end
    end
    
    
end
