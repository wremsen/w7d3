class SessionsController < ApplicationController


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
