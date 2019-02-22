Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/answer', to: 'holidays#answer'

  post '/event', to: 'holidays#event'
  
  post '/dtmf', to: 'holidays#dtmf'

  post '/date_type', to: 'holidays#date_type'

  post '/country_choice', to: 'holidays#country_choice'

  post '/holiday_output', to: 'holidays#holiday_output'

  post '/event', to: 'holidays#event'
end
