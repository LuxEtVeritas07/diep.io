import * as PIXI from 'pixi.js'
import io from 'socket.io-client'
import tanks from "./../public/assets/tanks.json"

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
	resolution: window.devicePixelRatio or 1

app.renderer.autoResize = true
document.body.appendChild app.view


class Tanks
	constructor:(tanks)->
		@tanks=tanks.tanks
		@types=tanks.types
		return
	Tank:(name,radius)->
		tank=@tanks[name]
		if tank is undefined
			console.error "Nie ma takiego czołgu!"
		container=new PIXI.Container


		for i in tank.addDowns
			if i.type is "rectangle"
				graphics=new PIXI.Graphics
				graphics.lineStyle 3, 0x5B6465
				graphics.beginFill 0x97989A
				graphics.drawRect i.offset[0]*radius-i.width/2*radius, i.offset[1]*radius-i.height/2*radius, i.width*radius, i.height*radius
				graphics.endFill()
				graphics.rotation=i.rotation/180*Math.PI
				container.addChild graphics
			else if @types[i.type] isnt undefined
				graphics=new PIXI.Graphics
				graphics.lineStyle 3, 0x5B6465
				graphics.beginFill 0x97989A
				p=true
				for j in @types[i.type]
					if p
						p=false
						graphics.moveTo j[0]*radius,j[1]*radius
					else
						graphics.lineTo j[0]*radius,j[1]*radius
					console.log j
				graphics.closePath()
				graphics.endFill()
				graphics.rotation=i.rotation/180*Math.PI
				container.addChild graphics
		if tank.shape is "circle"
			graphics=new PIXI.Graphics
			graphics.lineStyle 3, 0x5B6465
			graphics.beginFill 0x4BB6E0, 1
			graphics.drawCircle 0,0,radius
			graphics.endFill()
			container.addChild graphics
		else if tank.shape is "rectangle"
			graphics=new PIXI.Graphics
			graphics.lineStyle 3, 0x5B6465
			graphics.beginFill 0x4BB6E0, 1
			graphics.drawRect -radius,-radius,radius*2,radius*2
			graphics.endFill()
			container.addChild graphics
		return container
T=new Tanks tanks

player=T.Tank "necromancer",50

player.position.set window.innerWidth/2, window.innerHeight/2
app.stage.addChild player
