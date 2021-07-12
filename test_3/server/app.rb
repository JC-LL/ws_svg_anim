require_relative 'websocket_server'
require "json"

include Math

server = WebSocketServer.new

COLORS=['red','blue','green','gold','chartreuse','chocolate']
DX,DY,R=100,100,50
loop do
  Thread.new(server.accept) do |connection|
    puts "incoming connection !"
    while true
      message = connection.recv
      if message
        puts "Received from js : #{message}"
      end

      for i in 0..360
        scale=i
        rb_msg=[
          {cmd: "rotate"   , id:"star"      , args: [-20*i]},
          {cmd: "rotate"   , id:"spiral_1"  , args: [-20*i]},
          {cmd: "scale"    , id:"spiral_2"  , args: [(1+sin(0.5*i/PI)**2)/2]}
        ]
        connection.send(JSON.generate(rb_msg));
        sleep 0.1
      end
    end
  end
end
