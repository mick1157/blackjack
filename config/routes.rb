Blackjack::Application.routes.draw do

  resources :games

# resources :backjack_games

  get "home/index"

  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  get "new_game" => "games#new", :as => "new_game"
  get "end_game" => "games#destroy", :as => "end_game"
  get "new_deal" => "games#newdeal", :as => "new_deal"

  get "hit_games" => "games#hit", :as => "hit_games"
  get "stand_games" => "games#stand", :as => "stand_games"
  get "show_games" => "games#show", :as => "show_games"
  get "winner_games" => "games#winner", :as => "winner_games"

  get "start_debug" => "games#start_debug", :as => "start_debug"
  get "stop_debug" => "games#stop_debug", :as => "stop_debug"

  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "home#index"
  resources :users
  resources :sessions

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
