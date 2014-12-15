package dt.ui.button {
	import dt.ui.UIComponent;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * ...
	 * @author hmh
	 */
	public class Button extends UIComponent {
		public static var WIDTH:int = 100;
		public static var HEIGHT:int = 20;
		public static var ELLIPSE:int = 5;
		
		protected var textField:TextField;
		protected var textFormat:TextFormat;
		
		public function Button(label:String = null) {
			_width = Button.WIDTH;
			_height = Button.HEIGHT;
			textFormat = new TextFormat();
			textFormat.align = TextFormatAlign.CENTER;
			textField = new TextField();
			addChild(textField);
			this.label = label ? label : "";
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		override public function updateUI():void {
			textField.width = _width;
			textField.height = _height;
			drawBg();
			super.updateUI();
		}
		
		protected function drawBg():void {
			var colors:Array=[0xCCCCCC,0x666666];
			var alphas:Array=[1,1];
			var ratios:Array = [0,200];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width,_height,0.5*Math.PI,0,0);
			this.graphics.clear();
			this.graphics.beginGradientFill(GradientType.LINEAR ,colors, alphas, ratios, matr,SpreadMethod.PAD);
			this.graphics.drawRoundRect(0,0,_width,_height,Button.ELLIPSE);
			this.graphics.endFill();
		}
		
		public function set label(value:String):void {
			textField.text = value;
			textField.setTextFormat(textFormat);
		}
		
		public function get label():String {
			return textField.text;
		}
	}

}