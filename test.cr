require "./src/tba/head/irc"

server = TBA::Head::Server.create("esper")
head = TBA::Head::Head.create(server)
impl = TBA::Head::IRC.new(head, "irc.esper.net", "TBATest")

sleep
