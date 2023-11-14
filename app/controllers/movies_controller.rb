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
    post("/insert_movie") do
      Movie.create({:id => params.fetch("director_id_box"), :year => params.fetch("year_box"), :duration => params.fetch("duration _box"), :description => params.fetch("description_box"), :image => params.fetch("image_box"), :director_id => params.fetch("director_id_box")})
    end
    redirect_to("/movies")
  end

  def delete
    
  end

end
