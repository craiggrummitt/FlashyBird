package  {
	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Ground extends MovieClip {

		public static const SPEED:int = 6;
		public var ground:Bitmap;
		
		public function Ground(stage:Stage) {
			ground = new Bitmap(new GroundBD());
			ground.width = stage.stageWidth * (14/12);
			ground.scaleY = ground.scaleX;
			this.y = stage.stageHeight * 788/922;
			this.addChild(ground);
		}
		public function animate() {			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function stopAnimate() {
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void {
			ground.x-=SPEED;
			if (ground.x <= -stage.stageWidth * 2/12) {
				ground.x = 0;
			}
		}
	}
	
}
