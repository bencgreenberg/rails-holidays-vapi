Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/answer', to: 'holidays#answer'

  post '/event', to: 'holidays#event'
  
  post '/dtmf', to: 'holidays#dtmf'
end
