Rails.application.routes.draw do
  if Rails.env.development? || Rails.env.test?
    default_url_options :host => "localhost", port: 3000
  end

  get '/:shortcode', to: 'links#show', as: :shortcode
  get '/page/not_found', to: 'links#not_found', as: :not_found, format: 'json'
  post '/', to: 'links#create', as: :create_link, format: 'json'
end
