class MusicLibraryController

#accepts the path argument, with the defaul of ./db/mp3s
  def initialize(path = "./db/mp3s")
#creates a new MusicImporter object, passing in path value, and invokes import method
    MusicImporter.new(path).import
  end

  def call
    input = ""

#loops and asks for user input until they type in exit
    while input != 'exit'
#welcomes the user
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
#asks the user for input
      input = gets.strip

      case input
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end
  end

  def list_songs
#prints all songs in the music library in a numbered list (alphabetized by song name)
    Song.all.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
#prints all artists in the music library in a numbered list (alphabetized by artist name)
    Artist.all.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
#prints all genres in the music library in a numbered list (alphabetized by genre name)
    Genre.all.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
#prompts user to enter an artist
    puts "Please enter the name of an artist:"
#accepts user input
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if (1..Song.all.length).include?(input)
      song = Song.all.sort{ |a,b| a.name <=> b.name}[input - 1]
    end
      puts "Playing #{song.name} by #{song.artist.name}" if song
  end
end
