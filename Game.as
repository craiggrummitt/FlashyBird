package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.media.Sound;
	import flash.geom.Point;
	
	public class Game extends MovieClip {
		public static const TUBE_EVERY:int = 100;
		public static const GAME_OVER:String = "gameOver";
		//display objects
		private var bird:Bird;
		private var ground:Ground;
		private var tubes:Array;
		private var scoreTextField:TextField;
		private var textFormat:TextFormat;
		//vars
		public var score:int;
		private var count:int;
		//audio files
		private var hit:Sound;
		private var point:Sound;
		private var swoosh:Sound;
		private var wing:Sound;
		
		public function Game(bird:Bird,ground:Ground) {
			this.bird = bird;
			this.ground = ground;
			bird.turnGravityOn();
			bird.turboBoost();
			bird.stage.addEventListener(MouseEvent.CLICK,tapScreen);
			count = 0;
			score = 0;
			tubes = [];
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			
			setupScore();
			
			swoosh = new Swoosh();
			swoosh.play();
		}
		private function setupScore():void {
			scoreTextField = new TextField();
			scoreTextField.width = bird.stage.stageWidth;
			scoreTextField.y = bird.stage.stageHeight * 0.1;
			scoreTextField.mouseEnabled = false;
			this.addChild(scoreTextField);
			
			textFormat = new TextFormat();
			textFormat.font = "ChalkboardSE-Regular";
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.size = 50;
			
			scoreTextField.text = "0";
			scoreTextField.setTextFormat(textFormat);
		}
		private function tapScreen(event:MouseEvent) {
			bird.turboBoost();
			wing = new Wing();
			wing.play();
		}
		private function enterFrame(event:Event):void {
			var tube:Tube;
			//add a new tube if it's time
			count++;
			if (count > TUBE_EVERY) {
				count = 0;
				tube = new Tube(stage);
				tubes.push(tube);
				this.addChild(tube);
			}
			//Move the tubes
			for (var i:int = tubes.length-1;i>=0;i--) {
				tube = tubes[i];
				tube.x -= Ground.SPEED;
				//if moved off screen, remove
				if (tube.x + tube.width < 0) {
					this.removeChild(tube);
					tubes.splice(i,1);
					score++;
					scoreTextField.text = String(score);
					scoreTextField.setTextFormat(textFormat);
					point = new Point();
					point.play();
				} else 
				//did the bird make it past the tube?
				if (tube.x < bird.x - (bird.width / 2) &&
							tube.x + tube.width > bird.x + (bird.width / 2) &&
							(bird.y - (bird.height / 2) < tube.randomGapBeginning || 
								bird.y + (bird.height / 2) > tube.randomGapBeginning + tube.gapHeight)) {
								//oops - the birdy didn't make it through the tubes!
								this.gameOver();
					
				}
				
			}
			//Has the bird hit the ground?
			if (bird.y + (bird.height * 0.3) > ground.y) {
				bird.y = ground.y - (bird.height * 0.3);
				this.gameOver();
			}
		}
		private function gameOver():void {
			hit = new Hit();
			hit.play();
			
			this.dispatchEvent(new Event(GAME_OVER));
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			stage.removeEventListener(MouseEvent.CLICK,tapScreen);
		}
		public function removeTubes():void {
			//remove all tubes
			for (var i:int = tubes.length-1;i>=0;i--) {
				var tube:Tube = tubes[i];
				this.removeChild(tube);
			}
			tubes=[];
		}
	}
	
}
