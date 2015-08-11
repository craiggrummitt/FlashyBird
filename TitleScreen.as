package  {
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.Stage;
	
	public class TitleScreen extends MovieClip {
		private var title:TextField;
		private var instructions:TextField;
		public function TitleScreen(stage:Stage) {
			
			title = new TextField();
			title.width = stage.stageWidth;
			title.y = stage.stageHeight * 0.2;
			title.mouseEnabled = false;
			this.addChild(title);
			
			
			
			instructions = new TextField();
			instructions.width = stage.stageWidth;
			instructions.y = stage.stageHeight * 0.5;
			instructions.mouseEnabled = false;
			this.addChild(instructions);
			
			
		}
		public function changeTitle(title1:String,title2:String):void {
			title.text = title1;
			
			var textFormat = new TextFormat();
			textFormat.font = "ChalkboardSE-Regular";
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.size = 50;
			
			title.setTextFormat(textFormat);
						
			instructions.text = title2;			
			textFormat.size = 30;
			instructions.setTextFormat(textFormat);
		}
	}
	
}
