Joystick Hack

Mark Roland, markroland.com

Notes to self:

! This is a version-controlled project
! The arduino and processing folders should not be edited directly, but rather copied from their
	respective original locations

----------------------------

12/3/2011

1)	Set up repository. I'm logging this since I'm a git n00b and I won't remember how I did this.

		A)	Set up repository on local machine. From OS X command line (prompt is [joystick]#, where
				"joystick" is the working directory of the repository):
		
				[joystick]# git init
				[joystick]# git add *
				[joystick]# git commit -m 'initial project version'
		
		B)	Set up remote repository on github:
		
				[joystick]# git remote add origin git@github.com:markroland/Joystick.git
				[joystick]# git push -u origin master
			
		C)	Example of updating readme.txt:
		
				Move readme.txt to staging:
					
					[joystick]# git add readme.txt
					
				Commit to local repository:
				
					[joystick]# git commit -m "updated readme"
				
				Push to remote repository:
				
					[joystick]# git push -u origin master

2)	Arduino files must stay in Arduino folder to work properly and show up in the Arduino sketches,
		so I need to copy them from the Arduino directory (folder) to the repository folder.
		Same goes for Processing.
		
		Example:

			[joystick]# cp ~/Documents/Arduino/joystick/joystick.pde arduino/joystick.pde
			[joystick]# cp ~/Documents/Processing/joystick/* processing
