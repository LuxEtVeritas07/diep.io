import * as PIXI from 'pixi.js'
import io from 'socket.io-client'

socket = io ":8081"

socket.on "connect",()->
	console.log "CONNECTED!"
	socket.on "disconnect",()->
		console.log "DISCONNECTED!"
		return
	return

app = new PIXI.Application
	width: window.innerWidth
	height: window.innerHeight
	backgroundColor: 0x1099bb
	resolution: window.devicePixelRatio
	autoResize: true

document.body.appendChild app.view

tank_svg="/tanks/tank.svg"

tank_texture=new PIXI.Texture.from tank_svg

player=new PIXI.Sprite tank_texture


console.log player

app.ticker.add (delta)->
	player.rotation-=0.01*delta
	console.log player._textureID
	return
player.anchor.set 0.5
player.position.set window.innerWidth/2, window.innerHeight/2
app.stage.addChild player
