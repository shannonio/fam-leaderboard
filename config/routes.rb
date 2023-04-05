Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/scores', to: "sms_game_scores#index"
      get '/show/:id', to: 'sms_game_scores#show'
      delete '/destroy/:id', to: 'sms_game_scores#destroy'
    end
  end
  
  resource :messages do
    collection do
      post 'reply'
    end
  end

  get 'messages/reply'
  root 'homepage#index'
  get '/*path' => 'homepage#index'
end
