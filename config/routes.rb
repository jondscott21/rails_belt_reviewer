Rails.application.routes.draw do
  get '/events' => 'events#index'
  post '/events/create' => 'events#create'
  get '/events/:id/edit' => 'events#edit'
  put '/events/:id' => 'events#update'
  get '/events/:id' => 'events#show'

  get '/' => 'users#index'
  post '/create' => 'users#create'
  put 'users/:id' => 'users#update'
  get '/users/:id' => 'users#show'
  post '/login' => 'users#login'
  delete '/log_out/:user_id' => 'users#log_out'
  get '/plan/:id' => 'events#plan'
  delete '/cancel/:id' => 'events#cancel'
  post '/comment/:id' => 'events#comment'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
