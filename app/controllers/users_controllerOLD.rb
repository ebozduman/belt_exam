class UsersController < ApplicationController

    before_action :check_status, except: [:index, login, :create]

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
            first_name:params[:f_name],
            last_name:params[:l_name],
            email:params[:email],
            location:params[:location],
            location:params[:location],
            state:params[:state],
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

    def show
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
