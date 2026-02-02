This is a playable Version of Pong I made in Godot 4.3. It has both Single Player and 2 Player mode. Under release, both a web version and a windows version are avaible to download. You can also play the game in browser when clicking on the Link under "Pages"

Debug
The following changes were made in the project settings:
	For smoother (ball) movement:
	- Physics Interpolation was set to true
	- Physics Jitter Fix was set to 0, as required by Physics Interpolation
	
	As a possible solution(?) to prevent collision problems with the ball:
	- Physics Tics Per Second were increased from 60 to 120 

	To prevent the ball from stopping:
	- Default Linear Damp set to 0
	- Default Angular Damp set to 0

credits:
	sounds_ping_pong:	captaincrunch80 (opengameart.org)
	pong AUDIO:	yesme (opengameart.org)
