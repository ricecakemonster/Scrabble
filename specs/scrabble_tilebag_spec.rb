require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/scrabble_tilebag.rb'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "TileBag#initialize" do
  it "Creates a Scrabble::TileBag class" do
    tilebag = Scrabble::TileBag.new
    tilebag.must_be_kind_of Scrabble::TileBag
  end
end

describe "TileBag#draw_tiles" do
  it "Returns a collection of random tiles." do
    tilebag = Scrabble::TileBag.new
    tilebag.draw_tiles(5).must_be_kind_of Array
  end

  it "After draw, drawn tiles are removed from the default set" do
    tilebag = Scrabble::TileBag.new
    tilebag.draw_tiles(5)
    tilebag.all_tiles.values.inject(:+).must_equal 93
  end


end

describe "TileBag#tiles_remaining" do
  it "Returns the number of tiles remaining in the bag" do
    tilebag = Scrabble::TileBag.new
    tilebag.tiles_remaining.must_equal 98
  end

  it "Returns the number of tiles remaining in the bag after drawing some files" do
    tilebag = Scrabble::TileBag.new
    tilebag.draw_tiles(7)
    tilebag.tiles_remaining.must_equal 91
  end
end
