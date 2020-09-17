require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/blackjack_score'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe 'Blackjack Score' do
  it 'can calculate the score for a pair of number cards' do
    hand = [3, 4]
    score = blackjack_score(hand)
    expect(score).must_equal 7
  end

  it 'facecards have values calculated correctly' do
    hand = ["King", "Queen"]
    score = blackjack_score(hand)
    expect(score).must_equal 20
  end

  it 'calculates aces as 11 where it does not go over 21' do
    hand = ["Ace", 6, 2]
    score = blackjack_score(hand)
    expect(score).must_equal 19
  end

  it 'calculates aces as 1, if an 11 would cause the score to go over 21' do
    hand = ["Ace", 9, 6]
    score = blackjack_score(hand)
    expect(score).must_equal 16

    hand = ["Ace", 5, "Ace", 10, "Ace"]
    score = blackjack_score(hand)
    expect(score).must_equal 18
  end

  it 'raises an ArgumentError for invalid cards' do
    expect {
      blackjack_score([1, "King", 6])
    }.must_raise ArgumentError

    expect {
      blackjack_score(["Ace", 2, 11])
    }.must_raise ArgumentError

    expect {
      blackjack_score(["Spades", 3, 7])
    }.must_raise ArgumentError

    expect {
      blackjack_score([9, 4, 2.5])
    }.must_raise ArgumentError
  end

  it 'raises an ArgumentError for scores over 21' do
    expect {
      blackjack_score([8, 9, "Queen"])
    }.must_raise ArgumentError

    expect {
      blackjack_score([10, "King", "Ace", "Ace"])
    }.must_raise ArgumentError
  end

  it 'raises an ArgumentError if hand contains more than five cards' do
    hand = [2, 3, 4, 2, 3, 4]
    expect {
      blackjack_score(hand)
    }.must_raise ArgumentError
  end

  it 'raises an ArgumentError if hand contains fewer than two cards' do
    hand = ["King"]
    expect {
      blackjack_score(hand)
    }.must_raise ArgumentError
  end
end