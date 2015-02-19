class Song
  @@all = []
  attr_accessor :genre, :artist, :name

  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end

  def initialize
    save
  end

  def save
    @@all << self
  end

  def self.create_by_name(name_str)
    Song.new.tap do |s|
      s.name = name_str
    end
  end

  def to_s
    "#{self.artist.name} - #{self.name} [#{self.genre.name}]"
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name }
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
end