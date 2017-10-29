class Artist
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
#is initialized as an empty array
  @@all = []
#accepts a name for the new artist
  def initialize(name)
    @name = name
    @songs = []
  end
#returns the class variable @@all
  def self.all
    @@all
  end
#resets the @@all class variable to an empty array
  def self.destroy_all
    @@all.clear
  end
#adds the Artist instance to the @@all class variable
  def save
    @@all << self
  end

  def self.create(name)
    Artist.new(name).tap{ |n| n.save}
  end

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

  def genres
    songs.collect { |song| song.genre}.uniq
  end

end
