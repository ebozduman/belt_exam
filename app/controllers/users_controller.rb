class UsersController < ApplicationController

    before_action :check_status, except: [:index, :login, :create]

    def index
        redirect_to "/show" if session[:user_id]
    end

    def login
        user = User.find_by_email(params[:email])
        if user
            if user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect_to '/show'
            else
                flash[:errors] = ['Incorrect password!']
                redirect_to '/'
            end
        else
            flash[:errors] = ["Unknown email address! Please register first."]
            redirect_to '/'
        end
    end

    def create
        user = User.create(
            name:params[:name],
            alias:params[:alias],
            email:params[:email],
            password:params[:password],
            password_confirmation:params[:password_confirmation])

        if user.valid?
            session[:user_id] = user.id
            redirect_to '/show'
        else
            flash[:errors] = user.errors.full_messages
            redirect_to '/'
        end
    end

    def create_idea
        user = User.find(session[:user_id])
        idea = Idea.create(
            context:params[:context],
            user:user)
        redirect_to '/show'
    end

    def show
        @user = User.find(session[:user_id])
        @idea_list = Idea.all
    end

    def show_personal
        @user = User.find(params[:id])
        @post_count = @user.likes.count
        @like_count = Idea.where(user_id:params[:id]).count
    end

    def show_idea
        @idea = Idea.find(params[:id])
        @user = @idea.user
        @likers_list = @idea.likes
    end

    def delete
        Idea.find(params[:idea_id]).destroy
        redirect_to '/show'
    end

    def like
        Like.create(idea:Idea.find(params[:like_id]), user:User.find(session[:user_id]))
        redirect_to '/show'
    end

    def unlike
        Like.find(params[:like_id]).destroy
        redirect_to '/show'
    end

    def logout
        session[:user_id] = nil
        redirect_to '/'
    end

    private
    def check_status
        if !session[:user_id]
            redirect_to '/'
        end
    end
end
