package  {
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Stage;
	
	public class Tube extends MovieClip {
		private var tubeTop:Bitmap;
		private var tubeBottom:Bitmap;
		public var randomGapBeginning:int;
		public var gapHeight:int;
		public function Tube(stage:Stage) {
			this.mouseEnabled = false;
			tubeBottom = new Bitmap(new TubeBottom());
			tubeBottom.width = stage.stageWidth * 0.2;
			tubeBottom.scaleY = tubeBottom.scaleX;
			this.addChild(tubeBottom);
			
			tubeTop = new Bitmap(new TubeTop());
			tubeTop.width = stage.stageWidth * 0.2;
			tubeTop.scaleY = tubeTop.scaleX;
			this.addChild(tubeTop);

			this.gapHeight = stage.stageHeight * 0.27;
			var possibleGapBeginning:int = stage.stageHeight * 0.2;
			var possibleGapEnd:int = stage.stageHeight * 0.7;
			
			this.randomGapBeginning = possibleGapBeginning + (Math.random() * (possibleGapEnd - possibleGapBeginning - gapHeight));
			tubeTop.y = randomGapBeginning - tubeTop.height;
			tubeBottom.y = randomGapBeginning + gapHeight;
			
			this.x = stage.stageWidth;
		}

	}
	
}
