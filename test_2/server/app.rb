require_relative 'websocket_server'
require "json"

include Math

server = WebSocketServer.new

COLORS=['red','blue','green','gold','chartreuse','chocolate']
DX,DY,R=100,100,50
loop do
  Thread.new(server.accept) do |connection|
    puts "Connected"
    while true
      message = connection.recv
      if message
        puts "Received from js : #{message}"
      end
      fsm_exec=[1,2,4,5,2,4,5,2,4,5,2,4,5,2,4,6,2,3]
      fsm_exec.each_with_index do |i,idx|
        im1=fsm_exec[idx-1]
        rb_msg=[
          {cmd: "chgcolor", id: "node#{i}_ellipse"  , args: ["red"] },
          {cmd: "chgcolor", id: "node#{im1}_ellipse", args: ["white"] }
        ]

        connection.send(JSON.generate(rb_msg));
        sleep 0.5
      end
    end
  end
end
