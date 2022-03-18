Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :subs, only: [:edit,:update]
  end
  resource :session
  resources :subs
  resources :posts, only: [:new,:show,:create,:edit,:update,:destroy]
end
