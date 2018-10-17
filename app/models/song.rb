class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
     self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def note_contents=(notes)
    # self.save
    notes.each do |note|
      if !note.empty?
        # byebug
        # Note.create(content: note, song_id: self.id)
        # self.notes << [Note.create(content: note, song_id: self.id)]
        self.notes.build(content: note)
      end
    end
  end

  def note_contents
    # Note.all.select { |n| n.song_id == self.id }.map { |c| c.content }
    self.notes.map { |c| c.content }
  end

end
