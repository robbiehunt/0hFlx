package org.flixel 
{
	public class FlxPlayState extends FlxState
	{
		
		public var player:FlxSprite;
		public var hud:FlxGroup;
		
		private var hpBar:FlxSprite;
		private var hpBarFrame:FlxSprite;
		private var hpBarMax:Number;
		
		public function FlxPlayState() 
		{
			super();
			
			hud = new FlxGroup();
			add(hud);
			
			for each (var h:FlxSprite in hud.members)
			{
				h.scrollFactor.x = h.scrollFactor.y = 0;
			}
			
		}
		
		/**
		 * Add a healthbar to track the player objects health
		 * 
		 * @param	X : The X value of the HP Frame
		 * @param	Y : The Y value of the HP Frame
		 * @param	Width : The Width of the Frame
		 * @param	Height : The Height of the Frame
		 * @param	BarColor : The color of the bar
		 * @param	FrameColor : The color of the frame
		 */
		public function addHealthBar(X:Number = 5, Y:Number = 5, Width:Number = 100, Height:Number = 10, BarColor:uint=0xFFFFFFFF, FrameColor:uint=0xFF000000):void
		{
			
			hpBarFrame = new FlxSprite(X, Y);
			hpBarFrame.createGraphic(Width, Height, FrameColor);
			//hpBarFrame.scrollFactor.x = hpBarFrame.scrollFactor.y = 0;
			hud.add(hpBarFrame);
			
			hpBarMax = Width - 2;
			
			hpBar = new FlxSprite(hpBarFrame.x+1, hpBarFrame.y+1);
			hpBar.createGraphic(1,Height - 2, BarColor);
			//hpBar.scrollFactor.x = hpBar.scrollFactor.y = 0;
			hpBar.origin.x = hpBar.origin.y = 0;
			hpBar.scale.x = hpBarMax;
			hud.add(hpBar);
		}
		
		public function updateHealthBar():void
		{
			hpBar.scale.x = (player.health/100)*hpBarMax;
		}
		
	}

}