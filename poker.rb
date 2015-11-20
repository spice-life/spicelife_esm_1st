require 'bundler'
Bundler.require

class Poker
  attr_accessor :player1

  def initialize
    @player1 = Player.new
  end

  def kubaru
  end
end

class Player
  attr_accessor :hand

  def initialize
    @hand = Array.new(5)
  end
end

class Card
  def suit
    :heart
  end

  def number
    10
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
    it { expect(subject.suit).to eq(:heart) }
    it { expect(subject.number).to eq(10) }
  end
end
