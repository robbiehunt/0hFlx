package org.flixel
{
	
	public class FlxPlayer extends FlxSprite
	{
		
		private var moveType:String;
		
		private var defaultSpeed:Number = 130;
		
		private var jump:Number;
		
		private var stayInScreen:Boolean = false;
		
		/**
		 * Basic Player class, for a Shmup, Falling/Avoiding, or Platformer
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 * @param	Img				The asset you're using for the image.
		 */
		public function FlxPlayer(X:Number, Y:Number, Img:Class)
		{
			super(X, Y, Img);
			health = 100;
		}
		
		override public function update():void
		{
			if ((moveType == "horizontal") || (moveType == "jumper"))
			{
				velocity.x = 0;
			}
			else if (moveType == "vertical")
			{
				velocity.y = 0;
			}
			else if (moveType == "both")
			{
				velocity.y = 0;
				velocity.x = 0;
			}
			
			actions();
			
			super.update();
		}
		
		/**
		 * Handles Moving, Jumping, and binding player to screen
		 */
		
		public function actions():void
		{
			//Do we move left to right?
			if ((moveType == "horizontal") || (moveType == "both") || (moveType == "jumper"))
			{
				//Move Left and Right
				if(FlxG.keys.LEFT)
				{
					facing = FlxSprite.LEFT;
					
					velocity.x = -defaultSpeed;
				}
				else if(FlxG.keys.RIGHT)
				{
					facing = FlxSprite.RIGHT;
					
					velocity.x = defaultSpeed;
				}
				
				if (stayInScreen)
				{
					if (x < 0)
					{
						x = 0;
					}
					else if (x > (FlxG.width - this.width))
					{
						x = FlxG.width - this.width;
					}
				}
				
			}
			
			//Do we move up and down?
			if ((moveType == "vertical") || (moveType == "both"))
			{
				//Move Up and Down
				if(FlxG.keys.UP)
				{
					facing = FlxSprite.UP;
					
					velocity.y = -defaultSpeed;
				}
				else if(FlxG.keys.DOWN)
				{
					facing = FlxSprite.DOWN;
					
					velocity.y = defaultSpeed;
				}
				
				if (stayInScreen)
				{
					if (y < 0)
					{
						y = 0;
					}
					else if (y > (FlxG.height - this.height))
					{
						y = FlxG.height - this.height;
					}
				}
				
				
			}
			
			//Platform character
			if (moveType == "jumper")
			{
				//jump
				if ((FlxG.keys.UP) && (jump >= 0))
				{
					jump += FlxG.elapsed * 2;
					if (jump > 0.125)
					{
						jump = -1;
					}
					play("jumping");
				}
				else
				{
					jump = -1;
				}
				
				if (jump > 0)
				{
					if (jump < 0.065)
					{
						velocity.y = -270;
					}
					else
					{
						velocity.y = -maxVelocity.y;
					}
				}
				
			}
		}
		
		/**
		 * Set the player to not be able to move off the screen.
		 */
		public function stayOnScreen():void
		{
			stayInScreen = true;
		}
		
		/**
		 * Set player to move left and right
		 */
		public function giveHorizontalMovement():void
		{
			if (moveType == "vertical")
				moveType = "both";
			else
				moveType = "horizontal";
		}
		
		/**
		 * Set player to move up and down
		 */
		public function giveVerticalMovement():void
		{
			if (moveType == "horizontal")
				moveType = "both";
			else
				moveType = "vertical";
		}
		
		/**
		 * Set player to move in a Mario-like manner.
		 */
		public function makeJumper():void
		{
			moveType = "jumper";
			
			acceleration.y = 1200;
			maxVelocity.y = 350;
		}
		
		/**
		 * Set the players horizontal and verital movement
		 * @param	newSpeed the speed of movement
		 */
		public function setSpeed(newSpeed:Number = 1300):void
		{
			defaultSpeed = newSpeed;
		}
		
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void
		{
			if (moveType == "jumper")
			{
				jump = 0;
			}
			
            super.hitBottom(Contact, Velocity);
        }
		
	}
}