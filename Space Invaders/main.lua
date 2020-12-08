
love.graphics.setDefaultFilter('nearest','nearest')
enemy={}
enemies_controller = {}
enemies_controller.enemies ={}
player={}
alive = true
Letters = love.graphics.newFont('font.ttf', 64)

function love.load()
    
	
	player ={}
	player.x=0
	player.y=450
	player.bullets={}
	player.cooldown = 20
	player.speed = 2
	player.image = love.graphics.newImage('images/player.png')
		player.fire_sound = love.audio.newSource('sounds/shoot.wav', 'static')
		player.death_sound = love.audio.newSource('sounds/explosion.wav', 'static')

	player.fire=function()
		if player.cooldown <= 0 then
		    love.audio.play(player.fire_sound)
		    player.cooldown=40        
		    bullet={}
		    bullet.x= player.x + 90
		    bullet.y= player.y + 85
		    table.insert(player.bullets,bullet)
		end
	end

   
	enemies_controller.image= love.graphics.newImage('images/enemy.png')
	
	
	enemies_controller:spawnEnemy(0,-250)
	enemies_controller:spawnEnemy(100,-250)
	enemies_controller:spawnEnemy(200,-250)
	enemies_controller:spawnEnemy(300,-250)
	enemies_controller:spawnEnemy(400,-250)
	enemies_controller:spawnEnemy(500,-250)
	enemies_controller:spawnEnemy(600,-250)
	enemies_controller:spawnEnemy(700,-250)
	enemies_controller:spawnEnemy(0,-200)
	enemies_controller:spawnEnemy(100,-200)
	enemies_controller:spawnEnemy(200,-200)
	enemies_controller:spawnEnemy(300,-200)
	enemies_controller:spawnEnemy(400,-200)
	enemies_controller:spawnEnemy(500,-200)
	enemies_controller:spawnEnemy(600,-200)
	enemies_controller:spawnEnemy(700,-200)
	enemies_controller:spawnEnemy(0,-150)
	enemies_controller:spawnEnemy(100,-150)
	enemies_controller:spawnEnemy(200,-150)
	enemies_controller:spawnEnemy(300,-150)
	enemies_controller:spawnEnemy(400,-150)
	enemies_controller:spawnEnemy(500,-150)
	enemies_controller:spawnEnemy(600,-150)
	enemies_controller:spawnEnemy(700,-150)
	enemies_controller:spawnEnemy(0,-100)
	enemies_controller:spawnEnemy(100,-100)
	enemies_controller:spawnEnemy(200,-100)
	enemies_controller:spawnEnemy(300,-100)
	enemies_controller:spawnEnemy(400,-100)
	enemies_controller:spawnEnemy(500,-100)
	enemies_controller:spawnEnemy(600,-100)
	enemies_controller:spawnEnemy(700,-100)
	enemies_controller:spawnEnemy(0,-50)
	enemies_controller:spawnEnemy(100,-50)
	enemies_controller:spawnEnemy(200,-50)
	enemies_controller:spawnEnemy(300,-50)
	enemies_controller:spawnEnemy(400,-50)
	enemies_controller:spawnEnemy(500,-50)
	enemies_controller:spawnEnemy(600,-50)
	enemies_controller:spawnEnemy(700,-50)
	enemies_controller:spawnEnemy(0,0)
	enemies_controller:spawnEnemy(100,0)
	enemies_controller:spawnEnemy(200,0)
	enemies_controller:spawnEnemy(300,0)
	enemies_controller:spawnEnemy(400,0)
	enemies_controller:spawnEnemy(500,0)
	enemies_controller:spawnEnemy(600,0)
	enemies_controller:spawnEnemy(700,0)

end


function enemies_controller:spawnEnemy(x,y)
	
	
	enemy ={}
	enemy.x=x
	enemy.y=y
	enemy.width= 75
	enemy.height= 75

	enemy.speed = 0.2
	table.insert(self.enemies, enemy)
		
	

end





function love.update(dt)
	if alive and table.getn(enemies_controller.enemies) > 0 then
		player.cooldown= player.cooldown - 0.8

	
		if love.keyboard.isDown("right") then
			player.x= player.x + player.speed
		elseif love.keyboard.isDown("left") then
			player.x= player.x - player.speed
		end

		if love.keyboard.isDown("space")then
			player.fire()
		end

		for i,b in ipairs(player.bullets) do
			if b.y < 50 then
				table.remove(player.bullets,i)
			end	
			b.y= b.y - 5
		end


		for _,e in pairs(enemies_controller.enemies)do
			e.y=e.y+e.speed
		end

		checkCollisions(enemies_controller.enemies,player.bullets)
		checkDeath(enemies_controller.enemies,player)
	end
end



function checkCollisions(enemies, bullets)
	for i, e in ipairs(enemies) do
	    for _, b in ipairs(bullets) do
		if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
			table.remove(enemies, i)
		    table.remove(bullets, _)
		end
	    end
	end
end

function checkDeath(enemies, player)
	for i, e in ipairs(enemies) do
		if (player.y + 100) <= e.y + e.height then
			if alive then
				player.cooldown = 1000000000
				love.audio.play(player.death_sound)
				alive = false
			end
		end
	end
end

function love.draw()

	love.graphics.setColor(255,255,255)		
	love.graphics.draw(player.image, player.x, player.y,0,3)
	

	love.graphics.setColor(255,255,255)
	for _,e in pairs(enemies_controller.enemies) do
		love.graphics.draw(enemies_controller.image, e.x,e.y,0,1.5)
	end


	love.graphics.setColor(255,255,255)	
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	end

	if alive then
		if table.getn(enemies_controller.enemies) == 0 then
			love.graphics.setFont(Letters)
		love.graphics.printf("YOU WIN!", 0, 90, 800, 'center')
		end

	else
		love.graphics.setFont(Letters)
		love.graphics.printf("GAME OVER", 0, 90, 800, 'center')
	end
end