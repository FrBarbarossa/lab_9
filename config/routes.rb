Rails.application.routes.draw do
  root "palindromes#index"
  get "palindromes", to: "palindromes#index"
  get "palindromes/result", to: "palindromes#result", as: "res" 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
