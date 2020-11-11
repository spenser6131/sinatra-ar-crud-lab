
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  # index
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # new
  get '/articles/new' do
    erb :new
  end

  # create
  post '/articles' do
    article = Article.create(params)
    redirect to "/articles/#{article.id}"
  end

  # show
  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    if @article
      erb :'/show'
    else
      "Woops! That article doesn't exist."
    end
  end

  # edit
  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  # update
  patch '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.update(params[:article])
    redirect to "/articles/#{article.id}"
  end

  # destroy
  delete '/articles/:id' do
    article = Article.find_by_id(params[:id])
    Article.destroy(params[:id])
    redirect to '/articles'
  end

end
