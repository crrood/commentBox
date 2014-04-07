# requiref
require "socket"

# connection parameters
host = "localhost"
serverPort = "8080"

# create server
webserver = TCPServer.new('localhost', serverPort)
puts "listening on port " + serverPort + "\n\r"

# listen for requests
loop do

	# threaded to support multiple clients
	Thread.start(webserver.accept) do |session|
		
		# print request
		puts "session.gets: " + session.gets
		
		# response headers
		session.puts "http/1.1 200 ok"
		session.puts "Access-Control-Allow-Origin: *"
		session.puts ""

		# response body
		session.print "Hello world!"

		# send and close response
		session.close

		puts "session closed\n\r"

	end

end