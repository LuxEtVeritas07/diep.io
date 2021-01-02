express=require "express"
app=express()
port=8080

app.use express.static "#{__dirname}/public"

app.listen port, ()->
	console.log "Example app listening at http://localhost:#{port}"
	return
