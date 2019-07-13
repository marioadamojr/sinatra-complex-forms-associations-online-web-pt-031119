class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @owners = Owner.all
    @pet = Pet.create(name: params[:pet][:name])
    if params[:pet][:owner_ids]
      @pet.owner_id=params[:pet][:owner_ids].first
    elsif params[:owner_name]
      owner = Owner.create(name: params[:owner_name])
      @pet.owner = owner
    end
binding.pry
    # if !params[:owner][:name].empty?
    # @pet.owners << Owner.create(name: params[:owner][:name])
    # end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_ids")
      params[:pet][:owner_ids] = []
    end

    @pet = Pet.find(params[:id])
    @Pet.update(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner << Owner.create(name: params[:owner][:name])
    end
    redirect to "pets/#{@pet.id}"
  end
end
