def solve_sudoku(board)
    return if board.nil? || board.empty?
    if solve(board)
        puts board
    else 
        puts "This board is unsolvable"
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

# this board will be deleted once we get
# file input ready
board = 
   ["53..7....",
    "6..195...",
    ".98....6.",
    "8...6...3",
    "4..8.3..1",
    "7...2...6",
    ".6....28.",
    "...419..5",
    "....8..79"]

solve_sudoku(board)