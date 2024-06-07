class Player
  def initialize(name:, starting_hp:)
    @name = name
    @starting_hp = starting_hp
    @hp = starting_hp
  end

  def take(damage)
    self.hp = hp - damage
  end

  def alive?
    hp > 0
  end

  attr_accessor :hp
  attr_reader :name

  private

  attr_reader :starting_hp
end