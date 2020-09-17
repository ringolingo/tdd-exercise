# blackjack_score.rb

VALID_CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

def blackjack_score(hand)
  score = 0
  raise ArgumentError.new("your hand is too big") if hand.length > 5
  raise ArgumentError.new("your hand is too small") if hand.length < 2
  hand.each do |card|
    if !VALID_CARDS.include?(card)
      raise ArgumentError.new("that's not a real card. where did you even get that card?")
    elsif card.class == Integer
      score += card
    elsif ["King", "Queen", "Jack"].include?(card)
      score += 10
    elsif card == "Ace"
      score += 11
    end
  end
  ace_count = hand.select { |card| card == "Ace" }
  until score < 22 || ace_count.length == 0
    score -=10
    ace_count.pop
  end
  if score > 21
    raise ArgumentError.new("Sorry, buddy, you went bust")
  end
  return score
end