package org.flixel
{
	public class FlxTitle extends FlxState
	{
		
		private var title:FlxText;
		private var subTitle:FlxText;
		private var startText:FlxText;
		
		private var blinkInterval:Number = 1;
		private var blinkTimer:Number = blinkInterval;
		
		private var startVisible:Boolean = true;
		
		public function FlxTitle(Title:String = null, SubTitle:String = null, StartText:String = "Press [XXX]")
		{	
			if (Title != null)
			{
				title = new FlxText(0, 10, FlxG.width, Title);
				title.setFormat(null, 16, 0x000000, "center", 0);
				add(title);
				
				if (SubTitle != null)
				{
					subTitle = new FlxText(0, title.height + 5, FlxG.width, SubTitle);
					subTitle.setFormat(null, 8, 0x000000, "center", 0);
					add(subTitle);
				}
				
			}
			
			startText = new FlxText(0, FlxG.height - 24, FlxG.width, StartText);
			startText.setFormat(null, 8, 0x000000, "center", 0);
			add(startText);
			
		}
		
		override public function update():void
		{
			blinkTimer -= FlxG.elapsed;
			
			if (blinkTimer < 0)
			{
				
				if (startVisible)
				{
					blinkTimer = (blinkInterval) / 4;
				}
				else
				{
					blinkTimer = blinkInterval;
				}
				
				startVisible = !startVisible;
			}
			
			startText.visible = startVisible;
			
			trace(blinkTimer);
			
			super.update();
		}
		
		public function setColors(titleColor:uint = 0xFF000000, subTitleColor:uint = 0xFF000000, startColor:uint = 0xFF000000):void
		{
			title.color = titleColor;
			subTitle.color = subTitleColor;
			startText.color = startColor;
		}
		
	}
}