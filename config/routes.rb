WSN::Application.routes.draw do
  root 'main#index'
  get '/' => 'main#index'

  get '/play' => 'main#play'
  get '/play/:id' => 'main#trade'

  post '/vote/:id' => 'main#vote'
  post '/voteq/:id' => 'main#vote_quality'

  get '/results/:id' => 'main#results'

  get '/trades' => 'main#trades'
  get '/trades/new' => 'main#new_trades'

  get '/users/new' => 'user#new', :as => 'users'
  post '/users/new' => 'user#create'
  get '/users/:id' => 'user#show'

  get '/logout' => 'user#logout'
  get '/login' => 'user#login'
  post '/login' => 'user#post_login'
end
