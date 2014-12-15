package dt.ui.button {
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author hmh
	 */
	public class ToggleButton extends Button {
		public static const UP_STATUS:String = "up_status";
		public static const DOWN_STATUS:String = "down_status";
		
		protected var _isDown:Boolean = false;
		
		public function ToggleButton(label:String = null) {
			super(label);
		}
		
		override protected function drawBg():void {
			_isDown ? drawDownSkin() : drawUpSkin();
			textFormat.color = (_isDown ? 0xFFFFFF : 0x000000);
			this.label = label;
		}
		
		protected function drawUpSkin():void {
			var colors:Array = [0xCCCCCC, 0x666666];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 200];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, 0.5 * Math.PI, 0, 0);
			this.graphics.clear();
			this.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matr, SpreadMethod.PAD);
			this.graphics.drawRoundRect(0, 0, _width, _height, Button.ELLIPSE);
			this.graphics.endFill();
		}
		
		protected function drawDownSkin():void {
			var colors:Array = [0x666666, 0x333333];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 100];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, 0.5 * Math.PI, 0, -10);
			this.graphics.clear();
			this.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matr, SpreadMethod.PAD);
			this.graphics.drawRoundRect(0, 0, _width, _height, Button.ELLIPSE);
			this.graphics.endFill();
		}
		
		public function get status():Boolean {
			return _isDown;
		}
		
		public function set status(isDown:Boolean):void {
			_isDown = isDown;
			drawBg();
		}
		
	}

}