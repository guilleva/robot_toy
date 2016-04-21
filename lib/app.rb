# Main app class
class App
  def run
    display_greeting_message
    while (cmd = gets.chomp)
      break if cmd == 'QUIT'
    end
  end

  def display_greeting_message
    puts 'Hello!!!'
  end
end
