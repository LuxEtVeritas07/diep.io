app = require("express")()
http = require("http").createServer app
io = require("socket.io") http,{cors:{origin:"*"}}

app.get "/", (req, res) ->
	res.sendFile "#{__dirname}/index.html"
	return

io.on "connection", (socket) ->
	console.log "a user connected"
	return

http.listen 8081, ()->
	console.log "listening on *:8081"
	return
