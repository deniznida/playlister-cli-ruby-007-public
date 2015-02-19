class LibraryParser
  attr_accessor :path

  def initialize(path = "db/data")
    @path = path
  end

  def self.parse #this is a delegator that creates an instance of the LibraryParser class, and then tells it to parse itself. When you want a 'machine' to do it's job, it's pretty standard to call .call on it.
    LibraryParser.new.call # does this account for new instnaces of library parser that use a different path than the default???
  end

  def files
    # The point of this method is to read all the filenames
    # from the db/data
    @files = Dir["#{self.path}/*"]
    @files.collect do |file|
      file.gsub("#{self.path}/", "")
    end
  end

  def build_song(artist_name, song_name, genre_name)
    # a = Artist.create_by_name(artist_name)
    # g = Genre.create_by_name(genre_name)
    # s = Song.create_by_name(song_name)
    # s.genre = g
    # a.add_song(s)
    s = Song.new
    s.name = song_name
    # find_or_create_by_name
    s.artist = Artist.find_or_create_by_name(artist_name)
    s.genre = Genre.find_or_create_by_name(genre_name)
    s
  end

  def parse_filename(filename)
    parts = []
    parts[0] = filename.split(" - ").first
    parts[1] = filename.split(" - ").last.split(" [").first
    parts[2] = filename.split(" - ").last.split(" [").last.gsub("].mp3", "")
    parts
  end

  def call
    # 1. Load all the files
    self.files.each do |filename|
      # 2. For each file, parse the filename
      parts = self.parse_filename(filename)
      self.build_song(parts[0], parts[1], parts[2])
      # 3. Use those parts to build_song
    end
  end
end
