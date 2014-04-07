# requiref
require "socket"
require "uri"

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
		
		# output request
		request = session.gets
		puts "request: " + request

		# parse input
		puts input = request[(request.index("input") + 6)..(request.index("HTTP") - 2)]
		
		# response headers
		session.puts "http/1.1 200 ok"
		session.puts "Access-Control-Allow-Origin: *"
		session.puts ""

		# response body
		session.print "input string: " + URI.unescape(input)

		# write to file
		File.open("logs.txt", "a") { |file| file.write(URI.unescape(input) + "\r\n") }

		# send and close response
		session.close

		puts "session closed\n\r"

	end

end