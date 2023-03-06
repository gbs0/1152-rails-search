class MoviesController < ApplicationController
  def index
    if params[:query].present?
    #   sql_query = "title ILIKE :query OR synopsis ILIKE :query OR genre ILIKE :query"
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
      @movies = Movie.global_search(params[:query])
    elsif params[:genre].present?
      @movies = Movie.find_by_genre(params[:genre])
    else
      @movies = Movie.all
    end
  end
end
