package  {
	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class FlappyBird extends MovieClip {
		
		private var bg:Bitmap;
		private var ground:Ground;	
		private var titleScreen:TitleScreen;
		private var bird:Bird;
		private var game:Game;
		
		public function FlappyBird() {
			bg = new Bitmap(new BGBD());
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			this.addChild(bg);
			
			ground = new Ground(stage);
			this.addChild(ground);
			
			ground.animate();
			
			titleScreen = new TitleScreen(stage);
			
			bird = new Bird();
			this.addChild(bird);
			
			setUpTitleScreen();
		}
		private function setUpTitleScreen() {
			bird.reset();
			this.addChild(titleScreen);
			titleScreen.changeTitle("FLASHY BIRD","Tap to start");
			stage.addEventListener(MouseEvent.CLICK,tapTitleScreen);
		}
		
		private function tapTitleScreen(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.CLICK,tapTitleScreen);
			this.removeChild(titleScreen);
			game = new Game(bird,ground);
			game.addEventListener(Game.GAME_OVER,gameOver);
			this.addChild(game);
		}
		private function gameOver(event:Event):void {
			bird.turnGravityOff();
			ground.stopAnimate();
			game.removeEventListener(Game.GAME_OVER,gameOver);
			titleScreen.changeTitle("GAME OVER", "Tap to continue");
			this.addChild(titleScreen);
			stage.addEventListener(MouseEvent.CLICK,tapGameOverScreen);
		}
		private function tapGameOverScreen(event:MouseEvent):void {
			game.removeTubes();
			removeChild(game);
			stage.removeEventListener(MouseEvent.CLICK,tapGameOverScreen);
			ground.animate();
			setUpTitleScreen();
		}
	}
	
}
