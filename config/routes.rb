Rails.application.routes.draw do
    get '/' => 'users#index'

    post '/login' => 'users#login'
    delete '/logout' => 'users#logout'

    post '/create' => 'users#create'
    post '/bright_ideas' => 'users#create_idea'

    get '/show' => 'users#show'
    get '/users/:id' => 'users#show_personal'
    get '/bright_ideas/:id' => 'users#show_idea'

    post '/like' => 'users#like'
    post '/unlike' => 'users#unlike'
    delete '/delete' => 'users#delete'
end
