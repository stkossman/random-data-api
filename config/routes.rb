Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # API Version 1
  namespace :api do
    namespace :v1 do
      get 'random_data/number', to: 'random_data#number'
      get 'random_data/string', to: 'random_data#string'
      get 'random_data/name', to: 'random_data#name'
      get 'random_data/address', to: 'random_data#address'
      get 'random_data/date', to: 'random_data#date'
      get 'random_data/email', to: 'random_data#email'
      get 'random_data/uuid', to: 'random_data#uuid'
      get 'random_data/quote', to: 'random_data#quote'
      get 'random_data/credit_card', to: 'random_data#credit_card'
      get 'random_data/phone_number', to: 'random_data#phone_number'
      get 'random_data/bank_account', to: 'random_data#bank_account'
      get 'random_data/product', to: 'random_data#product'
      get 'random_data/company', to: 'random_data#company'
      get 'random_data/image', to: 'random_data#image'
      get 'random_data/lorem_words', to: 'random_data#lorem_words'
      get 'random_data/lorem_sentences', to: 'random_data#lorem_sentences'

      get 'random_data/error_simulation', to: 'random_data#error_simulation'

      # Маршрут для автентифікації (додамо його пізніше)
      post 'auth/login', to: 'authentication#login'
    end
  end

end
