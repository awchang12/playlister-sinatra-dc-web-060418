require 'rack-flash'
# require 'sinatra/base'
class SongsController < ApplicationController

    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all        

        erb :'/songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])

        erb :'/songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'/songs/edit'
    end

    post '/songs' do
        # binding.pry
        @song = Song.create(params[:song])
        params[:genres].each do |genre_id|
            genre = Genre.find(genre_id.to_i)
            @song.genres << genre
        end
        @song.save
        if !params["artist"]["name"].empty?
            artist = Artist.find_or_create_by(name: params["artist"]["name"])
            @song.update(artist: artist)
        end
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.update(genres: [])
        params[:genres].each do |genre_id|
            genre = Genre.find(genre_id.to_i)
            @song.genres << genre
        end
        @song.save
        if !params["artist"]["name"].empty?
            artist = Artist.find_or_create_by(name: params["artist"]["name"])
            @song.update(artist: artist)
        end
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end

end