require "secure_random"

class Hydra::Head::Channel
  getter uuid : String

  property name : String
  property server : Server
  getter users : Array(User)
  getter ops : Array(User)

  def initialize(@uuid)
    @users = [] of User
    @ops = [] of User

    # TODO: get from core
    @name = ""
    @server = Server.new(SecureRandom.uuid)
  end

  def self.create(name : String, server : Server)
    # TODO: Implement
    channel = Channel.new(SecureRandom.uuid)
    channel.name = name
    channel.server = server
    server.channels << channel
    channel
  end
end
