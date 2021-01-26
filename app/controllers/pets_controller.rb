class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end

  post '/pets' do 
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
    elsif params[:pet][:owner_id]
      owner = Owner.find(params[:pet][:owner_id])
    end 

    owner.pets.create(name: params[:pet][:name])
    redirect to "pets/#{Pet.last.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    # binding.pry
    pet = Pet.find(params[:id])
    pet.name = params[:pet][:name]

    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
    else
      owner = Owner.find_by(name: params[:owner][:name])
    end
    
    pet.owner = owner
    pet.save

    redirect "/pets/#{pet.id}"
  end

  patch '/pets/:id' do 
    redirect to "pets/#{@pet.id}"
  end
end