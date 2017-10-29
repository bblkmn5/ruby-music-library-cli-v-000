class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    Song.new(name).tap{ |s| s.save}
  end

  def self.find_by_name(name)
    all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
#split up the filename into corresponding parts
    parts = filename.split(" - ")
    artist_name = parts[0]
    song_name = parts[1]
#gsub off the unneeded .mp3
    genre_name = parts[2].gsub(".mp3", "")

#invokes the appropriate findable methods so as to avoid duplicate objects
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

#initializes a song based on passed-in filename
    Song.new(song_name, artist, genre)
  end

#initializes and saves a song based on passed-in filename
  def self.create_from_filename(filename)
#invokes .new_from_filename instead of re-coding same functionality
    new_from_filename(filename).tap{ |song| song.save}
  end
end