Rails.application.routes.draw do
  root "workouts#show"
  get "history", to: "workouts#history", as: :workout_history
  patch "workout/sets", to: "workouts#update", as: :workout_sets

  get "books", to: "books#index"
  get "books/new", to: "books#new", as: "new_book"
  post "books", to: "books#create"
  get "books/:id", to: "books#show", as: "book"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
