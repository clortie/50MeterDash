
local composer = require( "composer" )

local scene = composer.newScene()

native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
    composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

local function gotoTopTimes()
    composer.gotoScene( "toptimes", { time=800, effect="crossFade" } )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- load and display background image
	local background = display.newImageRect( sceneGroup, "menu_background.png", 1024, 768 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- create and display title
	local title = display.newText( sceneGroup, "Track & Field", display.contentCenterX, 180, native.systemFont, 80)
	title:setFillColor(1,1,1)

	-- create and display play button
	local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 400, native.systemFont, 44)
	playButton:setFillColor( 1, 1, 1 )

	-- create and display top times button
	local topTimesButton = display.newText( sceneGroup, "Top Times", display.contentCenterX, 500, native.systemFont, 44)

	-- event listeners for play and times buttons
	playButton:addEventListener( "tap", gotoGame )
	topTimesButton:addEventListener( "tap", gotoTopTimes )

	audio.reserveChannels( 1 )
	-- create music track
	local backgroundMusicTrack = audio.loadStream( "Just Move.mp3")

	-- start background music
	audio.setVolume( 0.4 ,{ channel=1 } )
	audio.play( backgroundMusicTrack, { channel=1, loops=-1 } )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		if ( system.getInfo("platformName") == "Android" ) then
		   local androidVersion = string.sub( system.getInfo( "platformVersion" ), 1, 3)
		   if( androidVersion and tonumber(androidVersion) >= 4.4 ) then
		     native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
		     --native.setProperty( "androidSystemUiVisibility", "lowProfile" )
		   elseif( androidVersion ) then
		     native.setProperty( "androidSystemUiVisibility", "lowProfile" )
		   end
		end		-- Code here runs when the scene is still off screen (but is about to come on screen)

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
		display.remove(background)
		display.remove(title)
		display.remove(playButton)
		display.remove(topTimesButton)
		audio.dispose(backgroundMusicTrack)
		backgroundMusicTrack=nil
		background=nil
		title=nil
		playButton=nil
		topTimesButton=nil

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose( backgroundMusicTrack )
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
