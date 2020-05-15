class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  accepts_nested_attributes_for :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end


  def note_ids=(ids)
    ids.each do |id|
      note = Note.find_or_create_by(id: id)
      self.notes << note
    end
  end

  def note_ids
    self.notes.map do |note|
      "song_notes_#{note.id}"
    end
  end

  def note_contents=(notes)
    notes.each do |note|
      self.notes.build(content: note).save if note
    end
  end

  def note_contents
    notes.collect {|note| note.content }
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end
end
