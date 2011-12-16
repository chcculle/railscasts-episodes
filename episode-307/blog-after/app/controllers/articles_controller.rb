class ArticlesController < ApplicationController
  rescue_from Tire::Search::SearchRequestFailed do |error|
    # Indicate incorrect query to the user
    if error.message =~ /SearchParseException/ && params[:query]
      flash[:error] = "Sorry, your query '#{params[:query]}' is invalid..."
    else
      # ... handle other possible situations ...
    end
    redirect_to root_url
  end

  def index
    @articles = Article.search(params)
  end
  
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new(article_id: @article.id)
  end
end
