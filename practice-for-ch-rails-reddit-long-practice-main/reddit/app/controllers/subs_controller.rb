class SubsController < ApplicationController
    before_action :is_moderator?, only: [:update, :edit]

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
        @sub = Sub.find(params[:id])

    end

    def update

    end

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end

    def is_moderator?
        current_user == @sub.moderator
    end
end
