class ApplicationController < Sinatra::Base
  require 'pry'
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    binding.pry
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    content = {
      name: params["name"],
      ingredients: params["ingredients"],
      cook_time: params["cook_time"]
    }
    binding.pry
    @recipe = Recipe.create(content)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  patch '/recipes/:id' do
    content = {
      name: params["name"],
      ingredients: params["ingredients"],
      cook_time: params["cook_time"]
    }
    @recipe = Recipe.update(params[:id], content)
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    Recipe.delete(params[:id])
    redirect '/recipes'
  end

end
