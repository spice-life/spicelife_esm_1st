require 'bundler'
Bundler.require

class Poker
  attr_accessor :player1

  def initialize
  end

  def hajimeru
    deck = Deck.new
    @player1 = Player.new
    @player1.yaku
  end
end

RSpec.describe Poker do
  describe '#hajimeru' do
    let(:poker) { Poker.new }
    it { expect(subject..player1).to be_a Player }
  end

  describe '#hajimeru' do
  end
end


class YakuwakaruMan
  PATTERN = []
  def initialize(cards)
    @cards = cards
  end

  def wakaru
    "ストレートフラッシュ"
  end
end

RSpec.describe YakuwakaruMan do
  it do
    expect(YakuwakaruMan.new(%w(s1 s2 s3 s4 s5)).wakaru).to eq "ストレートフラッシュ"
  end
end

class Player
  attr_accessor :hand

  def initialize
  end
end

RSpec.describe Player do
  describe '#yaku' do
    it { is_expected.to eq 'ストレートフラッシュ' }
  end
end


class Deck
  SUITES = %i{club heart spade dia}
  NUMBERS = 1..13
  def initialize
    @cards = []
    SUITES.each do |suit|
      NUMBERS.each do |number|
        @cards << Card.new(suit: suit, number: number)
      end
    end
  end

  def draw(num)
    @cards.shift(num)
  end
end

RSpec.describe Deck do
  describe '.new' do
    it { expect(subject.cards.size).to eq 52 }
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
