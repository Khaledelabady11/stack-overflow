Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  resources :questions
  

  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
end
