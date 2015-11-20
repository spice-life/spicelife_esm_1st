require 'bundler'
Bundler.require

class Poker
  attr_accessor :player1

  def initialize
    @deck = Deck.new
    @player1 = Player.new
  end

  def hajimeru
    @player1.yaku
  end
end

RSpec.describe Poker do
  describe '#hajimeru' do
    let(:poker) { Poker.new }
    it { expect(subject.player1).to be_a Player }
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
    case
    when four_of_kind?
      'フォーカード'
    when massugu_hikaru?
      'ストレートフラッシュ'
    else
      '🐷'
    end
  end

  def four_of_kind?
    @cards.map(&:number).uniq.count == 2
  end

  def full_house?
    numbers = @cards.map(&:number)
    hash = Hash.new 0
    numbers.each do |n|
      hash[n] += 1
    end

    hash.values.sort == [2, 3]
  end

  def three_of_kind?
    # [1, 1, 1, 8, 9] ok
    @cards.map(&:number).uniq.count == 3
  end

  def massugu_hikaru?
    @cards.map(&:suit).uniq.count == 1 &&
      @cards.map(&:number).uniq.count == 5 &&
      @cards.map(&:number).sort.last - @cards.map(&:number).sort.first == 4
  end
end

RSpec.describe YakuwakaruMan do
  describe '#three_of_kind' do
    let(:any_card_1) { Card.new(number: 9, suit: :dia) }
    let(:any_card_2) { Card.new(number: 8, suit: :spade) }

    let(:yakuwakaruman) {
      YakuwakaruMan.new(
        Deck::SUITES.take(3).map{|suit|
          Card.new(number: 1, suit: suit)
        } << any_card_1 << any_card_2
      )
    }

    subject { yakuwakaruman }

    it { is_expected.to be_three_of_kind }
  end

  describe '#full_house' do
    let(:any_card_1) { Card.new(number: 2, suit: :dia) }
    let(:any_card_2) { Card.new(number: 2, suit: :spade) }

    let(:yakuwakaruman) {
      YakuwakaruMan.new(
        Deck::SUITES.take(3).map{|suit|
          Card.new(number: 1, suit: suit)
        } << any_card_1 << any_card_2
      )
    }

    subject { yakuwakaruman }

    it { is_expected.to be_full_house }

  end

  describe '#massugu_hikaru?' do
    let(:yakuwakaruman) { YakuwakaruMan.new(cards) }

    subject { yakuwakaruman }

    context 'massugu hikaru' do
      let(:cards) {
        [
          Card.new(number: 1, suit: :spade),
          Card.new(number: 2, suit: :spade),
          Card.new(number: 3, suit: :spade),
          Card.new(number: 4, suit: :spade),
          Card.new(number: 5, suit: :spade)
        ]
      }

      it { is_expected.to be_massugu_hikaru }
    end

    context 'massugu hikaranai' do
      let(:cards) {
        [
          Card.new(number: 1, suit: :spade),
          Card.new(number: 2, suit: :spade),
          Card.new(number: 50000, suit: :spade),
          Card.new(number: 4, suit: :spade),
          Card.new(number: 5, suit: :spade)
        ]
      }

      it { is_expected.not_to be_massugu_hikaru }
    end
  end

  shared_context '役が4カード' do
    let(:any_card) { Card.new(number: 9, suit: :dia) }
    let(:yakuwakaruman) {
      YakuwakaruMan.new(
        Deck::SUITES.map {|suit|
          Card.new(number: 1, suit: suit)
        } << any_card
      )
    }
  end

  describe '#four_of_kind' do
    include_context '役が4カード'
    subject { yakuwakaruman }

    it { is_expected.to be_four_of_kind }
  end

  describe '#wakaru' do
    include_context '役が4カード'
    subject { yakuwakaruman.wakaru }

    it { is_expected.to eq 'フォーカード' }
  end
end

class Player
  attr_accessor :hand

  def initialize
  end

  def yaku
    YakuwakaruMan.new(@hand).wakaru
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
