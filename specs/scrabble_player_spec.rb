require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/scrabble_player.rb'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Player#initialize" do
  it "Creates a scrabble player class" do
    player = Scrabble::Player.new("Mickey")
    player.must_be_kind_of Scrabble::Player
  end

  it "Raises an ArgumentError when it's not created with name" do
    proc {
      Scrabble::Player.new("")
    }.must_raise ArgumentError
  end

  it "Should return the name of the player" do
    player = Scrabble::Player.new("Mickey")
    player.name.must_equal "Mickey"
  end

  it "Should return an empty array" do
    player = Scrabble::Player.new("Mickey")
    player.plays.must_be_empty
  end
end

describe "Player#play" do
  it "Raises an ArgumentError when other than alphabets are entered" do
    player = Scrabble::Player.new("Mickey")
    proc {
      player.play(23)
    }.must_raise ArgumentError
  end

  it "Returns false if player has already won" do
    player = Scrabble::Player.new("Mickey")
    player.play("qqqqq")
    player.play("zzzzza")
    player.won?
    player.play("whatever").must_equal false
  end

  it "Returns the score of the word" do
    player = Scrabble::Player.new("Mickey")
    player.play("red").must_equal 4
  end
end

describe "Player#total_score" do
  it "Returns the sum of scores of played words"do
    player = Scrabble::Player.new("Mickey")
    player.play("red")
    player.play("white")
    player.play("black")
    player.total_score.must_equal 28
  end
end

describe "Player#won?" do
  it "Returns true, if the player has over 100 points" do
    player = Scrabble::Player.new("Mickey")
    player.play("qqqqq")
    player.play("zzzzza")
    player.won?.must_equal true
  end
end

describe "Player#highest_scoring_word" do
  it "Returns the highest scoring played word" do
    player = Scrabble::Player.new("Mickey")
    player.play("red")
    player.play("white")
    player.play("black")
    player.highest_scoring_word.must_equal "black"
  end
end

describe "Player#higest_word_score" do
  it "Returns the highest_scoring_word score" do
    player = Scrabble::Player.new("Mickey")
    player.play("red")
    player.play("white")
    player.play("black")
    player.highest_word_score.must_equal 13
  end
end

describe "Player#tiles" do
  it "Returns a collection of letters that the player can play" do
    player = Scrabble::Player.new("Mickey")
    player.tiles.must_be_kind_of Array
  end

  it "Cannot have more than 7 tiles" do
    player = Scrabble::Player.new("Mickey")
    player.tiles.length.must_be :<=, 7
  end
end

describe "Player#draw_tiles(tile_bag)" do
  it "Fills tiles array until it has 7 letters from the given tile bag" do
    player = Scrabble::Player.new("Mickey")
    game_tile_bag = Scrabble::TileBag.new
    player.draw_tiles(game_tile_bag)
    player.tiles.length.wont_be :==, 0
  end

  it "Doesn't fill more tiles if player's tiles array is full(7)" do
    player = Scrabble::Player.new("Mickey")
    game_tile_bag = Scrabble::TileBag.new
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.draw_tiles(game_tile_bag)
    player.tiles.length.must_equal 7
  end
end
