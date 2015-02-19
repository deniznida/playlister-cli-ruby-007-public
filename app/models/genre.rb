class Genre
  attr_accessor :name, :songs
  @@all = []

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.find{|genre| genre.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name)
  end

  def self.create_by_name(name_str)
    Genre.new.tap do |g|
      g.name = name_str
    end
  end

  def self.reset_all
    @@all.clear
  end

  def self.count
    @@all.size
  end

  def initialize
    save
    @songs = []
  end

  def save
    @@all << self
  end

  def artists
    self.songs.collect{|s| s.artist}.uniq
  end
end