class Genre
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
#is initialized as an empty array
  @@all = []
#accepts a name for the new genre
  def initialize(name)
    @name = name
    @songs = []
  end
#returns the class variable @@all
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
    Genre.new(name).tap { |g| g.save}
  end

  def artists
    songs.collect{|song| song.artist}.uniq
  end
end
