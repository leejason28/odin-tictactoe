class Game

  attr_accessor :board, :x, :o
  
  def initialize
    @board = Board.new
    @x = Player.new('x')
    @o = Player.new('o')
  end

  def update_board(move)
    @board.array[move.row][move.column] = move.player.id
  end

  def game_over?
    if check_rows || check_cols || check_cross
      return true
    end
    return false
  end

  def check_rows
    @board.array.each do |row|
      if row[0]==row[1] && row[1]==row[2]
        if row[0]=='x' || row[0]=='o'
          return true
        end
      end
    end
    return false
  end

  def check_cols
    if @board.array[0][0] == @board.array[1][0] && @board.array[1][0] == @board.array[2][0]
      if is_player?(@board.array[0][0])
        return true
      end
    elsif @board.array[0][1] == @board.array[1][1] && @board.array[1][1] == @board.array[2][1]
      if is_player?(@board.array[0][1])
        return true
      end
    elsif @board.array[0][2] == @board.array[1][2] && @board.array[1][2] == @board.array[2][2]
      if is_player?(@board.array[0][2])
        return true
      end
    else
      return false
    end 
  end

  def check_cross
    if @board.array[0][0] == @board.array[1][1] && @board.array[1][1] == @board.array[2][2]
      if is_player?(@board.array[0][0])
        return true
      end
    elsif @board.array[0][2] == @board.array[1][1] && @board.array[1][1] == @board.array[2][0]
      if is_player?(@board.array[0][2])
        return true
      end
    else
      return false
    end 
  end

  def is_player? (pos)
    if pos == 'x' || pos == 'o'
      return true
    end
    return false
  end

end

class Board

  attr_accessor :array

  def initialize
    @array = Array.new(3) {Array.new(3, " ")}
  end

end

class Player

  attr_reader :id

  def initialize(id)
    if (id != 'x' && id != 'o')
      return "Enter a valid player id."
    end
    @id = id
  end

end

class Move

  attr_accessor :player, :row, :column

  def initialize(player, row, column)
    @player = player
    @row = row-1
    @column = column-1
  end

end


g = Game.new()
m1 = Move.new(g.x,2,2)
m2 = Move.new(g.x,1,1)
m3 = Move.new(g.x,3,3)
m4 = Move.new(g.o,3,1)
g.update_board(m1)
g.update_board(m2)
g.update_board(m3)
g.update_board(m4)
p g.board.array
p g.game_over?