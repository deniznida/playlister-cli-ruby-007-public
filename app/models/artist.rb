class Artist
  @@all = []
  attr_accessor :name, :songs

  def initialize
    @songs = []
    save
  end

  def save
    @@all << self
  end

  def self.create_by_name(name_str)
    a = Artist.new
    a.name = name_str
    a
    # Artist.new.tap do |a|
    #   a.name = name_str
    # end
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name)
    # s.artist = if Artist.find_by_name(artist_name)
    # Artist.find_by_name(artist_name)
    # else
    # Artist.create_by_name(artist_name)
    # end
    # s.artist = Artist.create_by_name(artist_name)
  end

  def self.find_by_name(name)
    self.all.find{|artist| artist.name == name }
  end

  def self.all
    @@all
  end

  def self.reset_all
    @@all.clear
  end

  def self.count
    @@all.size
  end

  def add_songs(songs)
    songs.each do |song|
      self.add_song(song)
    end
  end

  def add_song(song)
    self.songs << song
    song.artist = self unless song.artist == self
  # self.genres << song.genre
  # self.songs.push(song)
  # @songs << song
  end

  def genres
    self.songs.collect{|s| s.genre}.uniq
  end
end