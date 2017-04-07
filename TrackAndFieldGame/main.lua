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

---- set up track tiles
local trackGraphicsArray =
{
	frames =
	{
		--1)regular track
		{
			x=3,
			y=17,
			width=28,
			height=24
		},
		--2)track with starting blocks
		{
			x=32,
			y=17,
			width=38,
			height=24
		},
		--3)half track block with little marker
		{
			x=71,
			y=17,
			width=16,
			height=24
		},
		--4)finish line pre
		{
			x=87,
			y=1,
			width=22,
			height=40
		},
		--5)finish line post
		{
			x=110,
			y=1,
			width=22,
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

-- store track tiles into composer var
local trackSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", trackGraphicsArray )
composer.setVariable( "TrackTiles", trackSheet )

-- store background tiles into composer var
local backgoundSheet = graphics.newImageSheet( "NES - Track & Field - Tile Set.png", backgroundGraphicsArray )
composer.setVariable( "BackgoundTiles", backgoundSheet )

-- load menu screen
composer.gotoScene( "menu" )
