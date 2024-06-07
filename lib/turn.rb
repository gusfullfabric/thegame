class Turn
  def initialize(attacking_player:, defending_player:)
    @attacking_player = attacking_player
    @defending_player = defending_player
    @attack = nil
    @defence = nil
    @next_action = :attacking_player_to_roll
  end

  def completed?
    next_action == :turn_completed
  end

  def advance(die_sides)
    if attack && defence
    elsif attack
      self.defence = roll(die_sides)
      defending_player.take(damage)
    else
      self.attack = roll(die_sides)
    end

    self
  end

  def next_action
    if attack && defence
      :turn_completed
    elsif attack
      :defending_player_to_roll
    else
      :attacking_player_to_roll
    end
  end

  def damage
    return unless attack && defence

    [0, attack - defence].max
  end

  attr_accessor :attack, :defence
  attr_reader :attacking_player, :defending_player

  private

  def roll(die_sides)
    rand(1..die_sides)
  end
end