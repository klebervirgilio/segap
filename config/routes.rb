Pages::Application.routes.draw do
  namespace :api, :defaults => {:format => /(json|xml)/} do
    resources :pages do
      member do
        get :total_words
        post :publish
      end

      collection do
        get :published
        get :unpublished
      end
    end
  end
end
