class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:show]



    def new
        @user = User.new
        render :new
    end

    def create
        @user= User.new(user_params)
         if @user.save 
             redirect_to user_url(@user) # redirect to page
         else
             render json: @user.errors.full_messages, status: 422
         end
     end

     def show
        @user = User.find(params[:id])
        render :show
     end
 
     private
 
     def user_params
         params.require(:user).permit(:email, :password)
     end
end
