class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def create
    Director.create({:name => params.fetch("query_name"), :dob => params.fetch("query_dob"), :bio => params.fetch("query_bio"), :image => params.fetch("query_image")})

    redirect_to("/directors")
  end

  def update
    director_numb = params.fetch("id")

    Director.where({:id => params.fetch("id")}).at(0).update({:name => params.fetch("query_name"), :dob => params.fetch("query_dob"), :bio => params.fetch("query_bio"), :image => params.fetch("query_image")})

    redirect_to("/directors/"+director_numb)
  end

  def delete
    Director.where({:id => params.fetch("id")}).at(0).delete
    redirect_to("/directors")
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
