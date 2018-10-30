require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/pet.db")
class Pet
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
end
DataMapper.finalize.auto_upgrade!

#index
get '/pets' do
	@pets = Pet.all
	erb :'pets/index'
end

#new
get '/pets/new' do
	erb :'pets/new'
end

#create
post '/pets' do
	Pet.create({:name => params[:pet_name]})
	redirect '/pets'
end

#show
get '/pets/:id' do
	@pet = Pet.get(params[:id])
	erb :'pets/show'
end

#edit
get '/pets/:id/edit' do
	@pet = Pet.get(params[:id])
	erb :'pets/edit'
end

#update
patch '/pets/:id' do
	pet = Pet.get(params["id"])
	pet.update({:name => params[:pet_name]})
	redirect '/pets'
end

#Destroy
delete '/pets/:id' do
	pet = Pet.get(params["id"])
	pet.destroy
	redirect '/pets'
end
