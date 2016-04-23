require 'table'

# Class to control the robot
class Robot
  attr_reader :table, :face, :x, :y

  MOVES = {
    'NORTH' => [0, 1],
    'SOUTH' => [0, -1],
    'EAST' => [1, 0],
    'WEST' => [-1, 0]
  }

  ROTATIONS = {
    'NORTH' => { 'LEFT' => 'WEST',  'RIGHT' => 'EAST'  },
    'SOUTH' => { 'LEFT' => 'EAST',  'RIGHT' => 'WEST'  },
    'EAST'  => { 'LEFT' => 'NORTH', 'RIGHT' => 'SOUTH' },
    'WEST'  => { 'LEFT' => 'SOUTH', 'RIGHT' => 'NORTH' }
  }

  # Initializes the robot in the table
  def initialize(table)
    @table = table
    @x = @y = @face = nil
  end

  # Places the robot in a specific position
  def place(x, y, face)
    return unless valid_face?(face) && table.valid_position?(x, y)
    @x = x
    @y = y
    @face = face
  end

  def position
    [x, y, face]
  end

  def move
    return unless in_table? && !will_fall_off_table?
    (@x, @y) = next_position
  end

  # Returns true if the robot is on the table
  def in_table?
    @x && @y && @face
  end

  def next_position
    move = MOVES[face]
    [x + move[0], y + move[1]]
  end

  def rotate(cmd)
    @face = ROTATIONS[face][cmd] if in_table? && ROTATIONS[face].key?(cmd)
  end

  def to_s
    return "I'm in the limbo!" unless in_table?
    position.join(',')
  end

  private

  def will_fall_off_table?
    position = next_position
    !table.valid_position?(position[0], position[1])
  end

  def valid_face?(value)
    MOVES.key?(value)
  end
end
