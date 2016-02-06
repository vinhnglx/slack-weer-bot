$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
require 'weer'
require 'web'

# Load environment
Dotenv.load

# Run the Bot
Thread.abort_on_exception = true
Thread.new do
  begin
    Weer::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

# Run the Web
run Weer::Web
