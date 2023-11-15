class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    Movie.create({:title => params.fetch("query_title"), :year => params.fetch("query_year"), :duration => params.fetch("query_duration"), :description => params.fetch("query_description"), :image => params.fetch("query_image"), :director_id => params.fetch("query_director")})

    redirect_to("/movies")
  end

  def update
    movie_id = Movie.where({:id => params.fetch("id")}).at(0).id.to_s

     Movie.where({:id => params.fetch("id")}).at(0).update({:year => params.fetch("query_year"), :duration => params.fetch("query_duration"), :description => params.fetch("query_description"), :image => params.fetch("query_image"), :director_id => params.fetch("query_director")})
  
     redirect_to("/movies/"+movie_id.to_s)
  end

  def delete
    deleted_movie = Movie.where({:id => params.fetch("id")}).at(0)

    deleted_movie.delete
    
    redirect_to("/movies")
  end
end
