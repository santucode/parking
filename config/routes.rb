Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "small_slots#index"




  
  resources :parks
  resources :small_slots, :medium_slots, :large_slots
  
end
