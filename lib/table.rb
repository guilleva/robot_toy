require 'robot'

class Table
  WIDTH = 5
  HEIGHT = 5

  def valid_position?(x, y)
    valid_point_value?(x) && valid_point_value?(y) &&
      x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT
  end

  # Returns true if value is a valid integer to be used as point value
  # inside the table
  def valid_point_value?(value)
    value.is_a?(Integer) && value >= 0
  end
end
