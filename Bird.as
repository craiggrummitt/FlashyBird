package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bird extends MovieClip {
		private static const BOOSTER:int = 20;
		private static const GRAVITY_COEFFICIENT:int = 1;
		private static const MAX_GRAVITY:int = 10;
		private static const ANGLE:int = 45;
		
		private var currentVelocity:int = 0;
		
		private var gravityOn:Boolean = false;
		
		public function Bird() {
			this.mouseEnabled = false;
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function reset():void {
			this.rotation = 0;
			this.width = stage.stageWidth / 8;
			this.scaleY = this.scaleX;
			this.x = stage.stageWidth * 0.2;
			this.y = stage.stageHeight * 0.4;
		}
		public function turnGravityOn() {
			gravityOn = true;
		}
		public function turnGravityOff() {
			gravityOn = false;
		}
		public function turboBoost() {
			if (!gravityOn) return;
			currentVelocity = -BOOSTER;
		}
		private function enterFrame(event:Event):void {
			if (!gravityOn) return;
			currentVelocity += GRAVITY_COEFFICIENT;
			if (currentVelocity > MAX_GRAVITY) {
				currentVelocity = MAX_GRAVITY;
			}
			this.y+=currentVelocity;
			if (currentVelocity < -5) {
				this.rotation = -ANGLE;
			} else if (currentVelocity > 5) {
				this.rotation = ANGLE;
			} else {
				this.rotation = 0;
			}
		}
		
	}
	
}
