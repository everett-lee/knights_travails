

class Board
  attr_accessor :board
  def initialize
    @board = {
      8 => [8, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      7 => [7, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      6 => [6,' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      5 => [5,' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      4 => [4,' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      3 => [3,' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      2 => [2,' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      1 => [1, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      0 => [0,'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    }
  end

  def printer
    count = 8
    while count >= 0 do
      print "#{@board[count]} \n"
      count -= 1
    end
  end

  def update_board(space)
    @board[space[1]][space[0]] = "\u265E".unicode_normalize
  end
end

class Node
  attr_accessor :x, :y, :parent
  def initialize(start=nil, parent=nil)
    @x = start[0]
    @y = start[1]
    @parent = parent
  end
end

class Tree
  def initialize(start)
    @root = Node.new(start)
    @board = Board.new
  end

  #check for free space
  def within_board(space)
    inside = true
    if space[0] < 1 || space[0] > 8
      inside = false
    end
    if space[1] < 1 || space[1] > 8
      inside = false
    end
    return inside
  end

  def build_tree(target, current = @root)
    legal_moves = [[1,2], [-1,2], [2,1], [2,-1], [-1,-2], [1,-2], [-2,1], [-2,-1]]

    #loops until node in queue is equal to target
    queue = [current]
    loop do
        legal_moves.each do |i|
          space = [current.x + i[0], current.y + i[1]]
          if within_board(space)
            node = Node.new(space, current)
            queue << node
          end
        end
    queue.shift
    current = queue.first
    if [current.x, current.y] == target then break end
    end

  print "Path was: #{path(current)}"
  puts "\n"
  print "Reached in #{steps(current)} moves(s)"
  puts "\n"
  @board.printer
  end

  #backtracks path and returns as a string
  def path(current)
    output = " "
    path = [[current.x, current.y]]
    while current.parent != nil
      path << [current.parent.x, current.parent.y]
      current = current.parent
    end
    path.reverse!
    path.each do |space|
      output += "#{space} "
      @board.update_board(space)
    end
    output
  end

  def steps(current)
    steps = 0
    while current.parent != nil
      steps += 1
      current = current.parent
    end
    steps
  end
end

x = Tree.new([1,1])
x.build_tree([rand(7)+1,rand(7)+1])
