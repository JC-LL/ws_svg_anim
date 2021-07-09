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

      for i in 0..360
        deg=10*i
        color=COLORS.sample
        x,y=DX+R*sin(deg*PI/180),DY+R*cos(deg*PI/180)
        transform="translate(#{DX+x},#{DY+y}) rotate(#{deg})"
        font="Verdana"
        font_size=20+10*sin(i)**2
        stroke_width=4
        rb_msg=[
          {cmd: "move"     , id: "circle_1" , args: [x,y] },
          {cmd: "chgcolor" , id: "circle_1" , args: [color]   },
          {cmd: "translate", id: "circle_2" , args: [DX+x,y] },
          {cmd: "translate", id: "rect_1"   , args: [DX+x,100] },
          {cmd: "translate", id: "rect_2"   , args: [3*DY,DX+x] },
          {cmd: "rotate"   , id: "rect_3"   , args: [deg] },
          {cmd: "rotate"   , id: "square_1" , args: [-deg] },
          {cmd: "rotate"   , id: "square_2" , args: [2*deg] },
          {cmd: "transform", id: "rect_4"   , args: [transform] },
          {cmd: "rotate"   , id: "arrow"    , args: [deg] },
          {cmd: "text"     , id:"text_1"    , args: [2*y,2*x,font,font_size,stroke_width,color]},
          {cmd: "text"     , id:"text_2"    , args: [2*x,2*y,font,font_size,stroke_width,COLORS.sample]},
          {cmd: "rotate"   , id:"text_3"    , args: [3*deg]},
          {cmd: "scale"    , id:"rect_5"    , args: [1+sin(deg)**2]},
          {cmd: "scale"    , id:"circle_12" , args: [1+sin(deg)**2]},
        ]
        (3..11).each do |c|
          rb_msg << {cmd: "dmove"    , id: "circle_#{c}", args: [rand(-5..5),rand(-5..5)]  }
          rb_msg << {cmd: "chgcolor" , id: "circle_#{c}", args: [color]   }
        end
        connection.send(JSON.generate(rb_msg));
        sleep 0.1
      end
    end
  end
end
