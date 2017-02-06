gem 'minitest', '>= 5.0.0'
require 'minitest/reporters'
require 'minitest/autorun'
require_relative 'alouette'

Minitest::Reporters.use!

class AlouetteTest < Minitest::Test
  # Load the canonical lyrics from disk
  @@canonical_lyrics = File.read(File.dirname(__FILE__) + '/alouette_lyrics.txt').strip

  #
  # lines_for_verse
  #
  def test_lines_for_verse_returns_an_array_of_strings
    lines = Alouette.lines_for_verse(3)

    assert_kind_of Array, lines

    lines.each do |line|
      assert_kind_of String, line
    end
  end

  def test_lines_for_verse_generates_the_correct_line_for_the_first_verse

    assert_equal ['Et la tête!'], Alouette.lines_for_verse(0)
  end

  def test_lines_for_verse_generates_the_correct_lines_for_the_third_verse

    expected_lines = [
      "Et les yeux!",
      "Et le bec!",
      "Et la tête!"
    ]
    assert_equal expected_lines, Alouette.lines_for_verse(2)
  end

  #
  # verse
  #
  def test_verse_returns_a_string

    assert_kind_of String, Alouette.verse(3)
  end

  def test_first_two_lines_of_verse_begin_with_Je_te_plumerai

    lines = Alouette.verse(3).split("\n")

    # If there aren't at least 2 lines, don't continue
    assert_operator lines.length, :>, 1, "Not enough lines for this test"

    2.times do |i|
      assert lines[i].start_with?('Je te plumerai'), "Line #{i} didn't start with 'Je te plumerai'"
    end
  end

  def test_last_three_lines_of_verse_are_as_expected

    lines = Alouette.verse(3).split("\n")

    # If there aren't at least 3 lines, don't continue
    assert_operator lines.length, :>, 2, "Not enough lines for this test"

    assert_equal "Alouette!", lines[-3]
    assert_equal "Alouette!", lines[-2]
    assert_equal "A-a-a-ah", lines[-1]
  end

  def test_verse_middle_lines_begin_with_Et_and_end_with_bang

    lines = Alouette.verse(3).split("\n")

    # If there aren't at least 6 lines, don't continue
    assert_operator lines.length, :>, 5, "Not enough lines for this test"

    # Slice off the first 2 and last 3 lines
    lines = lines[2, lines.length-5]

    lines.each do |line|
      assert line.start_with?("Et "), "Inner line didn't start with 'Et '"
      assert line.end_with?("!"), "Inner line didn't end with '!'"
    end
  end

  def test_generates_the_third_verse

    expected_verse = <<-__END_VERSE__
Je te plumerai les yeux.
Je te plumerai les yeux.
Et les yeux!
Et les yeux!
Et le bec!
Et le bec!
Et la tête!
Et la tête!
Alouette!
Alouette!
A-a-a-ah
__END_VERSE__
    expected_verse.strip!
    assert_equal expected_verse, Alouette.verse(2)
  end

  #
  # sing
  #
  def test_sing_returns_a_string

    assert_kind_of String, Alouette.sing
  end

  def test_sing_begins_and_ends_with_the_refrain

    song = Alouette.sing
    refrain = "Alouette, gentille alouette,\nAlouette, je te plumerai."
    assert song.start_with?(refrain + "\n\n"), "Song didn't begin with the refrain"
    assert song.end_with?("\n\n" + refrain), "Song didn't end with the refrain"
  end

  def test_sing_generates_the_full_lyrics

    assert_equal @@canonical_lyrics, Alouette.sing
  end
end
