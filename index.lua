white = Color.new(255,255,255)
background = Color.new(40,40,40)

h,m,s = System.getTime()
seed = s + m * 60 + h * 3600
math.randomseed (seed)

dieRoll = math.random(1,6)
secondDieRoll = math.random(1,6)

rollCount = 0
secondDieIsEnabled = false
oldPad = Controls.read()
oldx, oldy = 0,0

touchLock = false

dieImages = {
 	Screen.loadImage(System.currentDirectory().."/images/1.png"),
	Screen.loadImage(System.currentDirectory().."/images/2.png"),
	Screen.loadImage(System.currentDirectory().."/images/3.png"),
	Screen.loadImage(System.currentDirectory().."/images/4.png"),
	Screen.loadImage(System.currentDirectory().."/images/5.png"),
	Screen.loadImage(System.currentDirectory().."/images/6.png")
}

while true do
	Screen.waitVblankStart()
	pad = Controls.read()
	Screen.refresh()
	Screen.clear(TOP_SCREEN)
	Screen.clear(BOTTOM_SCREEN)
	
	Screen.fillRect(0, 399, 0, 239, background, TOP_SCREEN)
	Screen.fillRect(0, 319, 0, 239, background, BOTTOM_SCREEN)

	x,y = Controls.readTouch()
	
	if (touchLock == false) and ((not (x == 0.0)) or ((Controls.check(pad,KEY_A)) and not (Controls.check(oldPad,KEY_A)))) then
	    dieRoll = math.random(1,6)
		secondDieRoll = math.random(1,6)
		rollCount = rollCount + 1
		touchLock = true
	end
	
	if (touchLock == true) and (x == 0.0) then
		touchLock = false
	end
	
	if (Controls.check(pad,KEY_B)) and not (Controls.check(oldPad,KEY_B)) then
		if (secondDieIsEnabled == true) then
			secondDieIsEnabled = false
		else
			secondDieIsEnabled = true
		end
	end
	
	Screen.debugPrint(6,6,"Rolled " .. rollCount .. " times",white,TOP_SCREEN)
	
	Screen.drawImage(56,10,dieImages[dieRoll],BOTTOM_SCREEN)
	if (secondDieIsEnabled == true) then
		Screen.drawImage(95,25,dieImages[secondDieRoll],TOP_SCREEN)
	end

	if secondDieIsEnabled then
		Screen.debugPrint(228, 6, "A to roll, B for one", white, TOP_SCREEN)
	else
		Screen.debugPrint(228, 6, "A to roll, B for two", white, TOP_SCREEN)
	end
	
	if (Controls.check(pad,KEY_START)) then
		System.exit()
	end
	
	oldPad = pad
	oldx,oldy = x,y
	Screen.flip()
end