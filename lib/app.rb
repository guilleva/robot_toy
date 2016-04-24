require 'robot'

# Main app class
class App
  ROTATION_COMMANDS = %w(LEFT RIGHT)

  MOVE_COMMAND = 'MOVE'

  REPORT_COMMAND = 'REPORT'

  QUIT_COMMAND = 'QUIT'

  PLACE_REGEXP = /\A
                  PLACE\s*                            # Command
                  (?<x>\d+)\s*,\s*                    # X
                  (?<y>\d+)\s*,\s*                    # Y
                  (?<face>NORTH|SOUTH|EAST|WEST)\s*   # FACE
                  \z/x

  attr_reader :robot

  def initialize
    @table = Table.new
    @robot = Robot.new(@table)
  end

  def run
    display_greeting_message
    while (cmd = gets.chomp)
      break if cmd == QUIT_COMMAND
      process_command cmd
    end
  end

  def process_command(cmd)
    case
    when cmd == MOVE_COMMAND
      @robot.move
    when cmd == REPORT_COMMAND
      output @robot.to_s
    when ROTATION_COMMANDS.include?(cmd)
      @robot.rotate(cmd)
    else
      attrs = PLACE_REGEXP.match(cmd)
      @robot.place(attrs[:x].to_i, attrs[:y].to_i, attrs[:face]) if attrs
    end
  end

  def display_greeting_message
    output 'Hello!!!'
  end

  def output(message)
    puts message
  end
end
