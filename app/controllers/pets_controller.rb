class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    # @owners = Owner.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet.owner = owner
      @pet.save
    end
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    # @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    # if !params[:pet].keys.include?("owner_ids")
    #   params[:pet][:owner_ids] = []
    # end
    @pet = Pet.find_by(params[:pet][:id])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner][:name])
    end
    @pet.update(params[:pet])

    redirect to "/pets/#{@pet.id}"
  end
end
