require "./src/hydra/head/irc"

server = Hydra::Head::Server.create("esper")
head = Hydra::Head::Head.create(server)
impl = Hydra::Head::IRC.new(head, "irc.esper.net", "HydraTest")

sleep
