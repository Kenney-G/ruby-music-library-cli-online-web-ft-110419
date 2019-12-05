require 'pry'
require 'findable'
class Artist
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  def initialize(name)
    self.name = name
    @@all << self
    @songs = [] 
    save
  end

  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << name
  end
  
  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end
  
  def genres
    self.songs.map{|song| song.genre}.uniq
  end
  
  def add_song(song)
  @songs << song unless @songs.include?(song)
  song.artist = self unless song.artist == self
  end


end