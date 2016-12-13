Rails.application.routes.draw do
  devise_for :users
	resources :pics
	resources :tags

	root "pics#index"

	get 'search' => 'pics#search', :as => 'search'
	get 'search_results' => 'pics#search_results', :as => 'search_results'
end
