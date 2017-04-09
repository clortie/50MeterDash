
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

---- set up track tiles
local trackGraphicsArray =
{
	frames =
	{
		--1)regular track
		{
			x=4,
			y=17,
			width=26,
			height=24
		},
		--2)track with starting blocks
		{
			x=33,
			y=17,
			width=36,
			height=24
		},
		--3)half track block with little marker
		{
			x=72,
			y=17,
			width=14,
			height=24
		},
		--4)finish line pre
		{
			x=88,
			y=1,
			width=20,
			height=40
		},
		--5)finish line post
		{
			x=111,
			y=1,
			width=20,
			height=40
		},
	}
}

---- set up backgound tiles
local backgroundGraphicsArray =
{
	frames =
	{
		--1)hills
		{
			x=113,
			y=149,
			width=25,
			height=79
		},
		--2)front grass
		{
			x=3,
			y=51,
			width=56,
			height=24
		},
		--3)back grass
		{
			x=3,
			y=42,
			width=56,
			height=8
		},
		--4)stadium wall
		{
			x=91,
			y=110,
			width=28,
			height=25
		},
		--5) pink crowd
		{
			x=120,
			y=117,
			width=28,
			height=15
		},
		--6) yellow crowd
		{
			x=149,
			y=117,
			width=28,
			height=15
		},
		--7) top of stands 1
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--8) top of stands 2
		{
			x=149,
			y=110,
			width=28,
			height=6
		},
		--9) front grass 2
		{
			x=59,
			y=51,
			width=56,
			height=24
		},
		--10) back grass 2
		{
			x=59,
			y=42,
			width=56,
			height=8
		},
	}
}

-- frames for top of stadium animation
local stadiumTopAnimateArray =
{
	frames =
	{
		--1)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--2)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--3)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--4)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--5)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--6)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--7)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--8)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--9)normal
		{
			x=120,
			y=110,
			width=28,
			height=6
		},
		--10)special
		{
			x=149,
			y=110,
			width=28,
			height=6
		},
	}
}

-- frames for crowd animation
local crowdAnimateArray =
{
	frames =
	{
		--1) pink crowd
		{
			x=120,
			y=117,
			width=28,
			height=15
		},
		--2) yellow crowd
		{
			x=149,
			y=117,
			width=28,
			height=15
		},
	}
}

local frontGrassAnimateArray = {
	frames =
	{
		--1)front grass 1
		{
			x=3,
			y=51,
			width=56,
			height=24
		},
		--2) front grass 2
		{
			x=59,
			y=51,
			width=56,
			height=24
		},
	}
}

local backGrassAnimateArray = {
	frames =
	{
		--1)back grass 1
		{
			x=3,
			y=42,
			width=56,
			height=8
		},

		--2) back grass 2
		{
			x=59,
			y=42,
			width=56,
			height=8
		},
	}
}


local trackAnimateArrayReg = {
	frames =
	{
		--1) marker
		{
			x=72,
			y=17,
			width=14,
			height=24
		},
		--2) regular
		{
			x=4,
			y=17,
			width=26,
			height=24
		},
	}
}

local trackAnimateArrayStart = {
	frames =
	{
		--1) starting blocks
		{
			x=33,
			y=17,
			width=36,
			height=24
		},
		--2) marker?
		{
			x=72,
			y=17,
			width=14,
			height=24
		},
	}
}

local trackAnimateArrayEnd = {
	frames =
	{
		-- 1) finish line
		{
			x=88,
			y=1,
			width=20,
			height=40
		},
		-- 2) reg track
		{
			x=4,
			y=17,
			width=26,
			height=24
		},
		-- 3) broken finish line
		{
			x=111,
			y=1,
			width=20,
			height=40
		},
	}
}

-- establish graphics sheets
local trackSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", trackGraphicsArray )
local backgroundSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", backgroundGraphicsArray )
local stadiumTopAnimateSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", stadiumTopAnimateArray )
local trackAnimateSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", trackAnimateArrayReg )
local crowdAnimateSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", crowdAnimateArray)
local backGrassAnimateSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", backGrassAnimateArray)
local frontGrassAnimateSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", frontGrassAnimateArray)

-- set up top of stadium sprite sequence
local sequence_topOfStadium = {
    -- consecutive frames sequence
    {
        name = "topOfStadiumAnimate",
		-- number of frames
        start = 1,
        count = 10,
		-- time to loop through all frames in ms
        time = 2000,
		-- how many times to run it (0 means indefinite)
        loopCount = 6,
		-- forward means circular, bounce means reverse at end
        loopDirection = "forward"
    }
}

-- set up crowd animate sprite sequence
local sequence_crowd = {
    -- consecutive frames sequence
    {
        name = "crowdAnimate",
		-- number of frames
        start = 1,
        count = 2,
		-- time to loop through all frames in ms
        time = 400,
		-- how many times to run it (0 means indefinite)
        loopCount = 30,
		-- forward means circular, bounce means reverse at end
        loopDirection = "forward"
    }
}

local sequence_frontGrass = {
	--consecutive frames sequence
	{
		name = "frontGrassAnimate",
		-- number of frames
		start=1,
		count=2,
		--time to loop through all frames in ms
		time = 400,
		--how many times to run it
		loopCount=30,
		loopDirection="forward"
	}
}

local sequence_backGrass = {
	--consecutive frames sequence
	{
		name = "backGrassAnimate",
		-- number of frames
		start=1,
		count=2,
		--time to loop through all frames in ms
		time = 400,
		--how many times to run it
		loopCount=30,
		loopDirection="forward"
	}
}

-- set up intial track animate sprite sequences
local sequence_trackStarting = {
	-- consecute frames sequence
	{
		name = "startingBlocksAnimate",
		--number of frames
		start = 1,
		count = 2,
		--time to loop through all frames in ms
		time = 2000,
		--how many time to run it
		loopCount = 1,
		loopDirection = "forward"
	}
}
local sequence_trackRegMiddle = {
	--consecutive frames sequence
	{
		name = "regularTrackAnimateMiddle",
		--number of frames
		start = 1,
		count = 2,
		--time to looop through all frames in ms
		time = 2000,
		loopCount = 5,
		loopDirection = "forward"
	}
}
local sequence_trackRegFrontEnd = {
	--consecutive frames sequence
	{
		name = "regularTrackAnimateFrontEnd",
		--number of frames
		start = 1,
		count = 2,
		--time to looop through all frames in ms
		time = 2000,
		loopCount = 4,
		loopDirection = "forward"
	}
}


local sequence_finishLine = {
	{
		name = "finishLine",
		start= 1,
		count= 2,
		time=2000,
		loopCount = 1,
		loopDirection="forward"
	}
}
-- table for stadium top animates
local stadiumAnimateTable = {}

-- create stadium top sprites and add to table
local i = 0
while i<8 do
	local newStadiumTopAnimate = display.newSprite(stadiumTopAnimateSheet , sequence_topOfStadium)
	stadiumAnimateTable[i] = newStadiumTopAnimate
	i=i+1
end

-- table for crowd animates
local crowdAnimateTable = {}
-- table for front grass animates
local frontGrassAnimateTable= {}
-- table for back grass animates
local backGrassAnimateTable= {}

--create crowd, front, and back grass sprites and add to tables
i=0
while i<8 do
	local newAnimate = display.newSprite(crowdAnimateSheet, sequence_crowd)
	crowdAnimateTable[i] = newAnimate
	newAnimate = display.newSprite(frontGrassAnimateSheet, sequence_frontGrass)
	frontGrassAnimateTable[i] = newAnimate
	newAnimate = display.newSprite(backGrassAnimateSheet, sequence_backGrass)
	backGrassAnimateTable[i] = newAnimate
	i=i+1
end




-- create initial track sprites and add to table


-- initialize variables
local speed = 0
local heatTime
local speedText
local timerText
local officialText

local backGroup
local mainGroup
local uiGroup

local runnningSound
local crowdSound
local gunSound

local gameLoopTimer
-- Declare top static track
local topStaticTrack = {}


local function endGame()
	composer.setVariable( "finalHeatTime", heatTime )
	composer.gotoScene( "toptimes" , {time=800, effect="crossFade"} )
end

local function gameLoop()
	-- start stadium and crowd animations
	for i=0,7 do
		if i%2==0 then
			crowdAnimateTable[i]:setFrame(2)
			backGrassAnimateTable[i]:setFrame(2)
			frontGrassAnimateTable[i]:setFrame(2)
		end
		stadiumAnimateTable[i]:setFrame(i+1)
	end
	for i=0,7 do
		crowdAnimateTable[i]:scale(4.57, 4.66)
		crowdAnimateTable[i].x = 64+128*i
		crowdAnimateTable[i].y = 245
		stadiumAnimateTable[i]:scale(4.57,6.66)
		stadiumAnimateTable[i].x = 64+128*i
		stadiumAnimateTable[i].y = 190
		backGrassAnimateTable[i]:scale(2.29,10)
		backGrassAnimateTable[i].x =64+128*i
		backGrassAnimateTable[i].y =448
		frontGrassAnimateTable[i]:scale(2.29,7.08)
		frontGrassAnimateTable[i].x =64+128*i
		frontGrassAnimateTable[i].y = 701
		crowdAnimateTable[i]:play()
		stadiumAnimateTable[i]:play()
		backGrassAnimateTable[i]:play()
		frontGrassAnimateTable[i]:play()

	end
end

local function startOfRace()
	-- do initial track animations
	for i=1,7 do
		initialTrackAnimateTable[i]:setFrame(2)
	end
	for i=0,7 do
		if i==0 then
			initialTrackAnimateTable[i]:scale(3.55, 5.33)
		else
			initialTrackAnimateTable[i]:scale(9.14, 5.33)
		end
		initialTrackAnimateTable[i].x = 64+128*i
		initialTrackAnimateTable[i].y = 552
		initialTrackAnimateTable[i]:play()
	end
end

local function endGame()
	composer.setVariable( "finalHeatTime", heatTime )
    composer.gotoScene( "toptimes", { time=800, effect="crossFade" } )
end

local function endOfRace()
	for i=0,7 do
		display.remove( crowdAnimateTable[i])
		display.remove( stadiumAnimateTable[i])
		display.remove( frontGrassAnimateTable[i] )
		display.remove( backGrassAnimateTable[i] )
		crowdAnimateTable[i] = nil
		stadiumAnimateTable[i] = nil
		frontGrassAnimateTable[i] = nil
		backGrassAnimateTable[i] = nil
		display.remove(initialTrackAnimateTable[i])
		initialTrackAnimateTable[i] = nil
	end
	-- send to top times
	timer.performWithDelay( 2000, endGame, 1 )

end

local function onYourMark()
	officialText.text = "On Your Mark!"
end

local function getSet()
	officialText.text = "Get Set!"
end

local function go()
	officialText.text = "GO!"
end

local function resetOfficialText()
	officialText.text = ""
end




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	-- pause the audio
	audio.pause( 1 )
	-- Set up display groups
	backGroup = display.newGroup()
	sceneGroup:insert(backGroup)

	mainGroup = display.newGroup()
	sceneGroup:insert(mainGroup)

	uiGroup = display.newGroup()
	sceneGroup:insert(uiGroup)



	-- Load the background for the race
	local sky = display.newImageRect(backGroup, "sky.png", 1024, 786)
	sky.x=display.contentCenterX
	sky.y=display.contentCenterY

	-- Load static front grass
	local staticFrontGrass = display.newImageRect(backGroup, backgroundSheet, 2, 1024, 170)

	staticFrontGrass.x = display.contentCenterX
	staticFrontGrass.y = display.contentHeight-85

	-- Load bottom static track to make up for blanks between track tiles
	local bottomStaticTrack = display.newImageRect(backGroup, trackSheet, 1, 1024, 128)
	bottomStaticTrack.x = display.contentCenterX
	bottomStaticTrack.y = 552

	for i=0,8 do
		local newStaticTrack
		if (i == 0 or i%2==0) then
			newStaticTrack = display.newImageRect( backGroup, trackSheet, 3, 128, 128)
		elseif (i == 1) then
			newStaticTrack = display.newImageRect( backGroup, trackSheet, 2, 128, 128)
		elseif (i%2 ~= 0) then
			newStaticTrack = display.newImageRect( backGroup, trackSheet, 3, 128, 128)
		end
		newStaticTrack.x = 64+128*i
		newStaticTrack.y = 552
		table.insert(topStaticTrack, newStaticTrack)
	end

	-- Load static back grass
	local staticBackGrass = display.newImageRect(backGroup, backgroundSheet, 3, 1024,80)
	staticBackGrass.x = display.contentCenterX
	staticBackGrass.y = 448

	-- Load stadium wall
	local stadiumWall = {}
	for i=0,8 do
		local newStadiumWall = display.newImageRect(backGroup, backgroundSheet, 4, 128,128)
		newStadiumWall.x = 64+128*i
		newStadiumWall.y = 344
		table.insert(stadiumWall, newStadiumWall)
	end

	-- Load crowd
	local crowd = {}
	for i=0,8 do
		local newCrowd
		if i%2==0 then
			newCrowd= display.newImageRect(backGroup, backgroundSheet, 5, 128, 70)
		else
			newCrowd= display.newImageRect(backGroup, backgroundSheet, 6, 128, 70)
		end
		newCrowd.x = 64+128*i
		newCrowd.y = 245
		table.insert(crowd, newCrowd)
	end

	-- Load top of stadium
	local stadiumTop = {}
	for i=0,8 do
		local newStadiumTop = display.newImageRect(backGroup, backgroundSheet, 7, 128, 40)
		newStadiumTop.x = 64+128*i
		newStadiumTop.y = 190
		table.insert(stadiumTop, newStadiumTop)
	end

	-- Load space for official text
	officialText = display.newText(uiGroup, "", 900, 344, native.systemFont, 36 )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		timer.performWithDelay( 1000, onYourMark, 1 )
		timer.performWithDelay( 2000, getSet, 1 )
		timer.performWithDelay( 3000, go, 1 )
		timer.performWithDelay( 4000, resetOfficialText, 1 )
		timer.performWithDelay( 3000, startOfRace, 1)
		timer.performWithDelay( 3000, gameLoop, 1)
		topStaticTrack[1] = display.newImageRect( backGroup, trackSheet, 3, 128, 128)
		topStaticTrack[1].x=64+128
		topStaticTrack[1].y=552
		timer.performWithDelay( 13000, endOfRace, 1)
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene( "game" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
