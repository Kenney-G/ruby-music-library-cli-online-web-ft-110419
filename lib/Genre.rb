
class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs, :artist
  
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
    @songs = []
    save
  end
  def songs
    @songs
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
    self.new(name)
  end
  
  def artists
    self.songs.map{|song| song.artist}.uniq
  end
  
end