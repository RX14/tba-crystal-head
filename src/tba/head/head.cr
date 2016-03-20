require "secure_random"

class TBA::Head::Head
  getter uuid : String

  property server : Server
  getter channels : Array(Channel)

  def initialize(@uuid)
    @channels = [] of Channel
    # TODO: get from core
    @server = Server.new(SecureRandom.uuid)
  end

  def self.create(server : Server)
    # TODO: Implement
    head = Head.new(SecureRandom.uuid)
    head.server = server
    head
  end
end
