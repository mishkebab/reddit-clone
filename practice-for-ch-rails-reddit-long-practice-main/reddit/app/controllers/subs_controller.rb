class SubsController < ApplicationController
    before_action :check_moderator?, only: [:update, :edit]
    before_action :require_logged_in, except: [:index, :show]

    def index
        @subs = Sub.all
    end

    def show
        @sub = Sub.find(params[:id])
    end

    def new
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def edit

    end

    def update
        @sub = Sub.find(params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end 
    end

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end

    def check_moderator?
        @sub = Sub.find(params[:id])
        if !(current_user == @sub.moderator)
            redirect_to sub_url(@sub)
        end
    end
end
