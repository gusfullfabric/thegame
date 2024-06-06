class Game
  # - Game has 2 players, each player has a 6 (or X) sided die, and 20 (or Y) of life points (HP)
  # - At each turn of the game, 1 player attacks and the other defends
  # - The attacker rolls the die to define the attack amount
  # - The defender rolls the die to define the defence amount
  # - The damage is taken by the defender and is defined as "attack - defence" (if positive)
  # - The next turn the roles of attacker and defender are switched
  # - Game runs until one of the players is dead (HP = 0)
  # - Game displays the winner

  # Questions
  # - Can players have dies with different sides, or is it one die for the game?
  # - Can they start with different HP?
  # - Depending on the UI, rolling the die could mean clicking a button on a webpage, or just pressing ENTER in
  # the terminal. We can implement that as an action, but there's a simpler approach where we just simulate
  # the game, requiring zero user input. My preference would be to start with a quick spike, more exploratory
  # approach, but I am happy to take your guidance here as there might be certain skills you're looking for me
  # to show. Which approach would you prefer?

  # Assumptions
  # - We are not trying to manage sessions. If we require user input, we assume two civilized players pressing
  # ENTER in turns, when they're asked to do so :)
end
