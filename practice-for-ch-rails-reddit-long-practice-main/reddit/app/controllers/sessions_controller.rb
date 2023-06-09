class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:destroy]

    def new
        @user = User.new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login!(@user)
            redirect_to subs_url
        else
            flash.now[:errors] = ["Invalid Credentials"]
            @user = User.new(username: params[:user][:username])
            render :new 
        end 
    end

    def destroy
        if logged_in?
            logout!
            redirect_to new_session_url
        end 
    end 
end
