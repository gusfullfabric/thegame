require 'game'
require 'player'
require 'turn'

RSpec.describe Game do
  let(:die_sides) { 6 }
  let(:starting_hp) { 20 }

  before { srand(123) }

  subject { described_class.new(die_sides: die_sides, starting_hp: starting_hp) }

  # - Game has 2 players, each player has a 6 (or X) sided die, and 20 (or Y) of life points (HP)
  # - At each turn of the game, 1 player attacks and the other defends
  # - The attacker rolls the die to define the attack amount
  # - The defender rolls the die to define the defence amount
  # - The damage is taken by the defender and is defined as "attack - defence" (if positive)
  # - The next turn the roles of attacker and defender are switched
  # - Game runs until one of the players is dead (HP = 0)
  # - Game displays the winner
  describe '#initialize' do
    it 'initializes the players with the right hp' do
      expect(subject.players.size).to eq(2)
      expect(subject.players.map(&:hp)).to eq([20, 20])
    end
  end

  describe '#current_turn' do
    context 'on the first turn, the first player is attacking' do
      let(:attacking_player) { subject.players.first }
      let(:defending_player) { subject.players.last }

      it 'returns attacking player, defending player, attack, defence, next_action' do
        turn = subject.current_turn

        expect(turn.attacking_player).to eq(attacking_player)
        expect(turn.defending_player).to eq(defending_player)
        expect(turn.attack).to be_nil
        expect(turn.defence).to be_nil
        expect(turn.next_action).to eq(:attacking_player_to_roll)
      end
    end
  end

  describe '#roll' do
    context 'when attacking' do
      let(:attacking_player) { subject.players.first }
      let(:defending_player) { subject.players.last }

      it 'rolls the die and assigns its value to the attack of the current turn' do
        subject.advance
        turn = subject.current_turn

        expect(turn.attacking_player).to eq(attacking_player)
        expect(turn.defending_player).to eq(defending_player)
        expect(turn.attack).to eq(6)
        expect(turn.defence).to be_nil
        expect(turn.next_action).to eq(:defending_player_to_roll)
      end
    end

    context 'when defending' do
      let(:attacking_player) { subject.players.first }
      let(:defending_player) { subject.players.last }

      before { subject.advance }

      it 'rolls the die and assigns its value to the defence of the current turn' do
        turn = subject.advance

        expect(turn.attacking_player).to eq(attacking_player)
        expect(turn.defending_player).to eq(defending_player)
        expect(turn.attack).to eq(6)
        expect(turn.defence).to eq(3)
        expect(turn.damage).to eq(3)
        expect(defending_player.hp).to eq(17)
        expect(turn.next_action).to eq(:turn_completed)
      end

      it 'current_turn now has the state of a new turn' do
        subject.advance
        turn = subject.current_turn

        expect(turn.attacking_player).to eq(defending_player)
        expect(turn.defending_player).to eq(attacking_player)
        expect(turn.attack).to be_nil
        expect(turn.defence).to be_nil
        expect(turn.next_action).to eq(:attacking_player_to_roll)
      end
    end

    context 'when the game ends' do
      let(:starting_hp) { 3 }

      let!(:attacking_player) { subject.players.first }
      let!(:defending_player) { subject.players.last }

      before do
        subject.advance
        subject.advance
      end

      it 'congratulates winner' do
        expect(subject.winner).to eq(attacking_player)
        expect(defending_player.hp).to eq(0)
      end
    end
  end
end
