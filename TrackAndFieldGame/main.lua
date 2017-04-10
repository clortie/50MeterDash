-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
if ( system.getInfo("platformName") == "Android" ) then
   local androidVersion = string.sub( system.getInfo( "platformVersion" ), 1, 3)
   if( androidVersion and tonumber(androidVersion) >= 4.4 ) then
     native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
     --native.setProperty( "androidSystemUiVisibility", "lowProfile" )
   elseif( androidVersion ) then
     native.setProperty( "androidSystemUiVisibility", "lowProfile" )
   end
end


-- include the Corona "composer" module
local composer = require "composer"

--set up object sheets for graphics



-- store background image as variable
composer.setVariable( "backgroundFileName", "menu_background.png" )

-- get random seed for use throughout game
math.randomseed(os.time())


-- load menu screen
composer.gotoScene( "menu" )
