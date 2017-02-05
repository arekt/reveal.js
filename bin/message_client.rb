require 'eventmachine'
require 'faye'

EM.run {
  client = Faye::Client.new('http://localhost:8123/faye')

  client.subscribe('/messages') do |message|
    puts message.inspect
  end
  case ARGV[0]
  when "hello"
    client.publish('/messages', 'text' => 'Hello world').callback do
      puts 'Message received by server!'
      EventMachine.stop
    end
  when "load_slides"
    files = Dir.entries("slides/").select {|f| !File.directory? f}
    slides = files.map do |file_name|
      content = File.read("slides/#{file_name}")
      puts "file: "#{file_name}"
      puts "content: \n"
      puts content
      content
    end
    client.publish('/slides', collection: slides).callback do
      puts 'Message received by server!'
      EventMachine.stop
    end
  else
    puts "commands: hello, load_slides"
    EventMachine.stop
  end
}
