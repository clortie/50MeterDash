
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- establish json object
local json = require( "json" )

-- table to hold best times
local timesTable = {}

-- get filepath
local filePath = system.pathForFile( "times.json", system.DocumentsDirectory)

-- load the times from the file, or make the times if there are none
local function loadTimes()

	local file = io.open( filePath, "r")

	if file then
		local contents = file:read("*a")
		io.close( file)
		timesTable = json.decode(contents)
	end

	if (timesTable == nil or #timesTable == 0 ) then
		timesTable = {"19.00s","18.00s","17.00s","16.00s","15.00s","14.00s","13.00s","12.00s","11.00s","10.10s"}
	end
end

-- save the times to the table
local function saveTimes()

	for i = #timesTable, 11, -1 do
		table.remove(timesTable,i)
	end

	local file = io.open(filePath)

	if file then
		file:write(json.encode(timesTable))
		io.close(file)
	end
end

local function gotoMenu()
	composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	loadTimes()

	-- Insert the saved time from the last game into the table, then reset it
	table.insert( timesTable, composer.getVariable("finalHeatTime"))
	composer.setVariable( "finalHeatTime", "99.99s" )

	-- Sort the table entries from highest to lowest
	local function compare(a,b)
		return a<b
	end

	-- display background
	local background = display.newImageRect( sceneGroup, "menu_background.png", 1024,786)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- display header
	local topTimesHeader = display.newText( sceneGroup, "Top Times", display.contentCenterX, 50, native.systemFont, 50)
	-- display your time if you had one
	if(timesTable[11]) then
		local yourTimeHeader = display.newText(sceneGroup, "Your time: "..timesTable[11], display.contentCenterX, 115, native.systemFont, 44)
	end

	-- sort the times
	table.sort(timesTable, compare)

	--save the times
	saveTimes()
	for i=1,10 do
		if (timesTable[i]) then
			local yPos = 120+(i*50)
			local rankNum = display.newText( sceneGroup, i .. ")", display.contentCenterX-50, yPos, native.systemFont, 30 )
			rankNum:setFillColor( 0.8 )
			rankNum.anchorX = 1

			local thisTime = display.newText( sceneGroup, timesTable[i], display.contentCenterX-30, yPos, native.systemFont, 30 )
			thisTime.anchorX = 0
		end
	end

	--establish menu button to listener for return to menu
	local menuButton = display.newText( sceneGroup, "Menu", display.contentCenterX, 700, native.systemFont, 44 )
    menuButton:setFillColor( 0.75, 0.78, 1 )
    menuButton:addEventListener( "tap", gotoMenu )

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
		composer.removeScene( "toptimes" )
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
