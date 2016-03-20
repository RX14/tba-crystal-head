require "socket"
require "fast_irc"
require "./../*"

class Hydra::Head::IRC
  def initialize(@head : Head, @host : String, @nick : String, @port : Int = 6667)
    @socket = TCPSocket.new(@host, @port, dns_timeout: 10.seconds, connect_timeout: 10)

    spawn do # reading fiber
      begin
        while line = @socket.gets("\r\n").try &.strip
          puts "<< " + line
          msg = FastIRC::Message.parse line.strip
          handle_incoming msg
        end
      ensure
        @socket.close
      end
    end

    send "NICK", [@nick]
    send "USER", [@nick, "0", "*", "Hydra Bot"]
  end

  def handle_incoming(message)
    case message.command
    when "PING"
      send "PONG", message.params
    when "001" # RPL_WELCOME
      on_connect
    when "353"
      channel_name = message.params[2]
      channel = @head.channels.find { |it| it.name == channel_name }
      return unless channel

      channel_users = message.params[3].split(' ')
      channel_users.each do |nick|
        if nick[0] == '@'
          op = true
          nick = nick[1..-1]
        end

        if nick[0] == '+'
          nick = nick[1..-1]
        end

        user = User.create(nick)
        channel.users << user
        channel.ops << user if op
      end
      puts Util.inspect_pretty @head.channels
    end

  end

  def on_connect
    join_channel "#RX14"
  end

  def join_channel(name)
    channel = Channel.create(name, @head.server)
    @head.channels << channel
    send "JOIN", [name]
  end

  def send(command, params : Array = nil, prefix : FastIRC::Prefix = nil, tags : Hash = nil)
    msg = FastIRC::Message.new(command, params, prefix, tags)
    puts ">> " + msg.to_s
    msg.to_s @socket
    @socket << "\r\n"
  end
end
