class Game
  attr_accessor :victory, :board

  def initialize
    @victory = false
    @board = Board.new
  end

  def game_over?
    
  end
end

class Board
  attr_reader :array

  def initialize
    @array = Array.new(3) {Array.new(3, " ")}
  end
end

class X
  SYMBOL = 'X'
end

class O
  SYMBOL = 'O'
end

module Playable
  def play(row, column)
    self.array[row][column] = SYMBOL
  end
end

g = Game.new
p g.board.array