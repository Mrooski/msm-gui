class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    Actor.create({:name => params.fetch("query_name"), :dob => params.fetch("query_dob"), :bio => params.fetch("query_bio"), :image => params.fetch("query_image")})

    redirect_to("/actors")
  end

  def update
    actor_numb = params.fetch("id")

    Actor.where({:id => params.fetch("id")}).at(0).update({:name => params.fetch("query_name"), :dob => params.fetch("query_dob"), :bio => params.fetch("query_bio"), :image => params.fetch("query_image")})

    redirect_to("/actors/"+actor_numb)
  end

  def delete
    Actor.where({:id => params.fetch("id")}).at(0).delete
    redirect_to("/actors")
  end

end
