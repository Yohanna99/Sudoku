def initial_val(board)
  
  (0...board.length).each do |row|
    (0...board[row].length).each do |col|
      next unless board[row][col] != "."
      char = board[row][col]

      (0...9).each do |m|

        if m != col && board[row][m] != "."

          return false if board[row][m] == char # check row
        end
        if m != row && board[m][col] != "."

          return false if board[m][col] == char # check col

        end
        if row != (3 * (row / 3) + m / 3) && col != (3 * (col / 3) + m % 3)  &&  board[3 * (row / 3) + m / 3][3 * (col / 3) + m % 3] != "."
          return false if board[3 * (row / 3) + m / 3][3 * (col / 3) + m % 3] == char # check 3 * 3 block
        end
      end
    end   
  end
end


def print_board(board)
  border = "+-----+-----+-----+"
  9.times do |i|
    puts border if i%3 == 0
    9.times do |j|
      print j%3==0 ? "|": " "
      print board[i][j]
    end
    puts "|"
  end
  puts border
end



def solve_sudoku(board)
    puts "Original Board: \n"
    (0...board.length).each do |row|
      board[row] = board[row].chomp #removes newline character at end of string
    end
    puts print_board(board)
    return if board.nil? || board.empty?
    if initial_val(board)
      if solve(board)
        puts "Finished Board:"
        puts print_board(board)
      else 
        puts "This board is unsolvable"
      end
    else
      puts "This board is invalid"
    end
      
end
  
def solve(board)
    (0...board.length).each do |row|
        (0...board[row].length).each do |col|
            next unless board[row][col] == '.'
            
            '1'.upto('9').each do |char|
                next unless is_valid?(board, row, col, char)
                
                board[row][col] = char
                
                return true if solve(board) # call solve recursively
                
                board[row][col] = '.' # back track
            end
        
            return false # all combinations failed, return false
        end
    end

    return true ## board is fully filled, return true
end

def is_valid?(board, row, col, char)
    (0...9).each do |i|
        return false if board[row][i] != '.' && board[row][i] == char # check row
        return false if board[i][col] != '.' && board[i][col] == char # check col
        return false if board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] != '.' && board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == char # check 3 * 3 block
    end
end


puts "Do you want to play sudoku?: [y/n]"
r = $stdin.gets.chomp
while true
if r == "y"
    puts "Enter your sudoku board file:"
    b = $stdin.gets.chomp
  begin
   board = File.readlines(b) #reads lines of file into array
  rescue
    puts "File not found!"
    exit 
  end
    solve_sudoku(board)
    puts "Want to play again? [y/n]"
    replay = $stdin.gets.chomp
    if replay == "n"
      puts "Thanks for playing!"
      break
    end
end
if r == "n"
  puts "OK, maybe next time"
  break
end
end
exit
