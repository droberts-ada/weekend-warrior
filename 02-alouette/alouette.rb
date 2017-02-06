class Alouette
  REFRAIN = "Alouette, gentille alouette,\nAlouette, je te plumerai."
  VERSE_INTRO = "Je te plumerai "
  VERSE_OUTRO = "Alouette!\nAlouette!\nA-a-a-ah"

  ALOUETTE_PARTS = [
    "la tête",
    "le bec",
    "les yeux",
    "le cou",
    "les ailes",
    "les pattes",
    "la queue",
    "le dos"
  ]

  def self.lines_for_verse(verse_number)
    ALOUETTE_PARTS[0, verse_number + 1].reverse.map do |part|
      "Et #{part}!"
    end
  end

  def self.verse(verse_number)
    lyrics = ""
    part = ALOUETTE_PARTS[verse_number]
    2.times { lyrics += VERSE_INTRO + part + ".\n" }
    lines_for_verse(verse_number).each do |line|
      2.times { lyrics += line + "\n" }
    end
    lyrics += VERSE_OUTRO
  end

  def self.sing
    lyrics = REFRAIN
    ALOUETTE_PARTS.length.times do |v|
      lyrics += "\n\n"
      lyrics += verse(v)
      lyrics += "\n\n"
      lyrics += REFRAIN
    end
    return lyrics
  end
end
