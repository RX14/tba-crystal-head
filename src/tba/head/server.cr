require "secure_random"

class TBA::Head::Server
  getter uuid : String

  property name : String
  getter channels : Array(Channel)

  def initialize(@uuid)
    @channels = [] of Channel
    # TODO: get from core
    @name = ""
  end

  def self.create(name)
    # TODO: Implement
    server = Server.new(SecureRandom.uuid)
    server.name = name
    server
  end

  def self.find(name = nil, uuid = nil)
    raise "Can't have noth name and uuid" if name && uuid

    if name
      create name
    elsif uuid
      Server.new(uuid)
    end
  end
end
