require 'bundler'
Bundler.require

class Poker
  attr_accessor :player1

  def initialize
    @player1 = Player.new
  end
end

class Player
  attr_accessor :hand

  def initialize
    @hand = Array.new(5)
  end
end

class Deck
  def initialize
    %i{club heart spade dia}.each{}
    @cards = 53.times.map{ Card.new(suit: :heart, number: 1) }
  end

  def draw(num)
    @cards.shift(num)
  end
end

class Card
  attr_reader :suit, :number

  def initialize(suit:, number:)
    @suit   = suit
    @number = number
  end
end

class Dealer
  def initialize
    @deck = Deck.new
  end

  # カードを配る
  def execute(num = 5)
    @deck.draw(num)
  end
end

RSpec.describe Poker do
  describe '.new' do
    it { expect(subject.player1).to be_a Player }
  end
end

RSpec.describe Player do
  describe '.new' do
    it { expect(subject.hand).to be_a Array }
    it { expect(subject.hand.size).to eq(5) }
  end
end

RSpec.describe Card do
  describe '.new' do
    subject { Card.new(suit: suit, number: number) }

    context 'club 1' do
      let(:suit)   { :club }
      let(:number) { 1 }

      it { expect(subject.suit).to eq :club }
      it { expect(subject.number).to eq 1 }
    end
  end
end

RSpec.describe Dealer do
  describe '#execute' do
    let(:num) { 5 }

    subject {
      Dealer.new.execute(num)
    }

    it { expect(subject.size).to eq 5 }
  end
end
