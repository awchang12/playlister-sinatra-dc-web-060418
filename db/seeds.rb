# Add seed data here. Seed your database with `rake db:seed`
Song.destroy_all
Genre.destroy_all
Artist.destroy_all
SongGenre.destroy_all

artist = Artist.create(name: "Adele")
song = Song.create(name: "hello", artist: artist)
genre = Genre.create(name: "pop")
sg = SongGenre.create(song: song, genre: genre)




