require "secure_random"

class TBA::Head::User
  getter uuid : String

  property nickname : String
  getter channels : Array(Channel)
  getter servers : Array(Server)

  def initialize(@uuid)
    @channels = [] of Channel
    @servers = [] of Server

    # TODO: get from server
    @nickname = ""
  end

  def self.create(nick)
    # TODO: Implement
    user = User.new(SecureRandom.uuid)
    user.nickname = nick
    user
  end
end
