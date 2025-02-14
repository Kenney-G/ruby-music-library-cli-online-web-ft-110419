require 'pry'
require 'findable'
class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    @@all << self
    @artist = artist
    self.artist = artist if artist != nil
    @genre = genre
    self.genre = genre if genre != nil
    save
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
    song = Song.new(name)
  end
  
  def artist
    @artist
  end
  
  def artist=(artist)  
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    filename_array = filename.split(" - ")
    song_artist = Artist.find_or_create_by_name(filename_array[0])
    song_genre = Genre.find_or_create_by_name(filename_array[2].split(".mp3")[0])
    song = Song.new(filename_array[1],song_artist,song_genre)
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
  end

end

# require "spec_helper"

# describe "Song" do
#   let(:song) { Song.new("In the Aeroplane Over the Sea") }

#   describe "#initialize" do
#     it "accepts a name for the new song" do
#       new_song = Song.new("Alison")

#       new_song_name = new_song.instance_variable_get(:@name)

#       expect(new_song_name).to eq("Alison")
#     end
#   end

#   describe "#name" do
#     it "retrieves the name of a song" do
#       expect(song.name).to eq("In the Aeroplane Over the Sea")
#     end
#   end

#   describe "#name=" do
#     it "can set the name of a song" do
#       song.name = "Jump Around"

#       song_name = song.instance_variable_get(:@name)

#       expect(song_name).to eq("Jump Around")
#     end
#   end

#   describe "@@all" do
#     it "is initialized as an empty array" do
#       all = Song.class_variable_get(:@@all)

#       expect(all).to match_array([])
#     end
#   end

#   describe ".all" do
#     it "returns the class variable @@all" do
#       expect(Song.all).to match_array([])

#       Song.class_variable_set(:@@all, [song])

#       expect(Song.all).to match_array([song])
#     end
#   end

#   describe ".destroy_all" do
#     it "resets the @@all class variable to an empty array" do
#       Song.class_variable_set(:@@all, [song])

#       Song.destroy_all

#       expect(Song.all).to match_array([])
#     end
#   end

#   describe "#save" do
#     it "adds the Song instance to the @@all class variable" do
#       song.save

#       expect(Song.all).to include(song)
#     end
#   end

#   describe ".create" do
#     it "initializes, saves, and returns the song" do
#       created_song = Song.create("Kaohsiung Christmas")

#       expect(Song.all).to include(created_song)
#     end
#   end
# end