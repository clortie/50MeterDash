-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )



-- include the Corona "composer" module
local composer = require "composer"

--set up object sheets for graphics



-- store background image as variable
composer.setVariable( "backgroundFileName", "menu_background.png" )

-- get random seed for use throughout game
math.randomseed(os.time())

-- reserve audio channel for game music
audio.reserveChannels( 1 )
-- Reduce the overall volume of the channel
audio.setVolume( 0.5, { channel=1 } )

-- load menu screen
composer.gotoScene( "menu" )
