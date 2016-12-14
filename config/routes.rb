Rails.application.routes.draw do

  devise_for :users
	resources :pics
	resources :tags
	resources :users, :only => [:view]

	root "pics#index"

	get 'search' => 'pics#search', :as => 'search'
	get 'search_results' => 'pics#search_results', :as => 'search_results'
    get '/users/:id'=> 'users#view', :as => 'view'

end
