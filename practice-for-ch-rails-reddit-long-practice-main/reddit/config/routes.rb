Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:new, :create] 
  
  resources :posts, except: [:index, :destroy, :create] #show, new, create, #edit, #update
  resources :subs, except: [:destroy] do
    resources :posts, only: [:create]
  end
  resource :session, only: [:new, :create, :destroy]
end
