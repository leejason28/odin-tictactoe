class Game

  attr_accessor :board, :x, :o
  
  def initialize
    @board = Board.new
    @x = Player.new('x')
    @o = Player.new('o')
    @current = @x
    @winner = 'none'
  end

  def update_board(move)
    @board.array[move.row][move.column] = move.player.id
  end

  def game_over?
    if check_rows || check_cols || check_cross
      return true
    elsif self.is_full?
      return true
    else
      return false
    end
  end

  def check_rows
    @board.array.each do |row|
      if row[0]==row[1] && row[1]==row[2]
        if row[0]=='x' || row[0]=='o'
          @winner = row[0]
          return true
        end
      end
    end
    return false
  end

  def check_cols
    if @board.array[0][0] == @board.array[1][0] && @board.array[1][0] == @board.array[2][0]
      if is_player?(@board.array[0][0])
        @winner = @board.array[0][0]
        return true
      end
    elsif @board.array[0][1] == @board.array[1][1] && @board.array[1][1] == @board.array[2][1]
      if is_player?(@board.array[0][1])
        @winner = @board.array[0][1]
        return true
      end
    elsif @board.array[0][2] == @board.array[1][2] && @board.array[1][2] == @board.array[2][2]
      if is_player?(@board.array[0][2])
        @winner = @board.array[0][2]
        return true
      end
    else
      return false
    end 
  end

  def check_cross
    if @board.array[0][0] == @board.array[1][1] && @board.array[1][1] == @board.array[2][2]
      if is_player?(@board.array[0][0])
        @winner = @board.array[0][0]
        return true
      end
    elsif @board.array[0][2] == @board.array[1][1] && @board.array[1][1] == @board.array[2][0]
      if is_player?(@board.array[0][2])
        @winner = @board.array[0][2]
        return true
      end
    else
      return false
    end 
  end

  def is_full?
    empty = 0
    for i in 0..2
      for j in 0..2
        if @board.array[i][j] == " "
          empty += 1
        end
      end
    end
    return empty == 0
  end

  def is_player? (pos)
    if pos == 'x' || pos == 'o'
      return true
    end
    return false
  end

  def valid_move? (row, col)
    if row<1 || row>3
      return false
    elsif col<1 || col>3
      return false
    else
      if @board.array[row-1][col-1] == " "
        return true
      end
    end
    return false
  end

  def play
    p @board.array
    p "Hello. Welcome to Tic-Tac-Toe."
    p "Enter your moves in the format: row# column#."
    while !self.game_over?
      p "Player #{@current.id}, what is your move?"
      user_response = gets
      user_rc = user_response.chomp.split
      user_rc.map! { |num| num.to_i}
      p user_rc
      if valid_move?(user_rc[0], user_rc[1])
        user_move = Move.new(@current, user_rc[0], user_rc[1])
        update_board(user_move)
        if @current.id == 'x'
          @current = @o
        else
          @current = @x
        end
        p @board.array  
        p " "
      else
        p "Please enter a valid move. Valid moves contain empty spaces where row and column numbers are in between 1 and 3 inclusive."
      end
    end
    if @winner == 'none'
      p "Tie game!"
    else
      p "Player #{@winner} wins!"
    end
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
    if id != 'x' && id != 'o'
      return "Enter a valid player id."
    end
    @id = id
  end

end

class Move

  attr_accessor :player, :row, :column

  def initialize(player, row, column)
    if row<1 || row>3
      return "Enter a valid row number"
    elsif column<1 || column>3
      return "Enter a valid column number"
    else
      @player = player
      @row = row-1
      @column = column-1
    end
  end

end

g = Game.new()
g.play