
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
	}
}

-- establish graphics sheets
local trackSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", trackGraphicsArray )
local backgroundSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", backgroundGraphicsArray )

-- initialize variables
local speed = 0
local heatTime
local timer
local speedText
local timerText
local officialText

local backGroup
local mainGroup

local runnningSound
local crowdSound
local gunSound


local function endGame()
	composer.setVariable( "finalHeatTime", heatTime )
	composer.gotoScene( "toptimes" , {time=800, effect="crossFade"} )
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
	-- Load top static track
	local topStaticTrack = {}
	for i=0,8 do
		local newStaticTrack
		if (i == 0 or i%2==0) then
			newStaticTrack = display.newImageRect( backGroup, trackSheet, 1, 128, 128)
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
		local newCrowd = display.newImageRect(backGroup, backgroundSheet, 5, 128, 70)
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

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
