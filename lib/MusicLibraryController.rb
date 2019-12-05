class MusicLibraryController

  def initialize (path = './db/mp3s')
    data = MusicImporter.new(path)
    data.import
  end
  
  def call
    input = ''
    while input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.strip
     
      def list_songs
          order = Song.all.sort_by {|song| song.name}
          order.each_with_index do |song, index|
          puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            end
      end
      def list_artists
        order = Artist.all.sort_by {|artist| artist.name}
        order.each_with_index do |artist, index|
          puts "#{index + 1}. #{artist.name}"
        end
      end
      def list_genres
         order = Genre.all.sort_by {|genre| genre.name}
        order.each_with_index do |genre, index|
          puts "#{index + 1}. #{genre.name}"
        end
      end
      def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
          if artist = Artist.find_by_name(input)
            artist.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
            end
          end
      end
      def list_songs_by_genre 
        puts "Please enter the name of a genre:"
        input = gets.strip
        if genre = Genre.find_by_name(input)
          genre.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
          puts "#{i}. #{song.artist.name} - #{song.name}"
          end
        end
      end
      def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        songs = Song.all
        if (1..songs.length).include?(input)
          song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
        end
        puts "Playing #{song.name} by #{song.artist.name}" if song
      end
#-----------------------------------------------------------------

      case input
        when 'list songs'
          self.list_songs
        when 'list artists'
          self.list_artists
        when 'list genres'
          self.list_genres
        when 'list artist'
          self.list_songs_by_artist
        when 'list genre'
          self.list_songs_by_genre
        when 'play song'
          self.play_song
        when 'exit'

        end
      end
  end
end 