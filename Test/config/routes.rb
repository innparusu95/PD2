Test::Application.routes.draw do
  root :to => "contents#index"
  get "contents/index"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy"
end
