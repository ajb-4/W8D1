class PoemsController < ApplicationController

before_action :require_logged_in, only: [:new, :create, :index, :edit, :update]

    def new
        @poem = Poem.new
        render :new
    end


    def index
        @poems = Poem.all
        render :index
    end

    def create
        @poem = Poem.new(poem_params)
        @poem.author = current_user
        if @poem.save
            redirect_to poems_url
        else
            flash.now[:errors] = @poem.errors.full_messages
            render :new
        end
    end

    def edit
        @poem = Poem.find(params[:id])
        render :edit
    end

    def update
        @poem = Poem.find(params[:id])
        if @poem.author_id == current_user.id &&  @poem.update(poem_params)
            redirect_to poems_url
        else
            flash.now[:errors] = ['Something went wrong!']
            render :edit
        end
    end



    def poem_params
        params.require(:poem).permit(:title, :stanzas, :complete)
    end

end
