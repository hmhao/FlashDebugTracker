package dt.ui.text {
	import dt.ui.UIComponent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author hmh
	 */
	public class TextInput extends UIComponent {
		public static var WIDTH:int = 100;
		public static var HEIGHT:int = 20;
		
		protected var input:TextField;
		
		public function TextInput() {
			input = new TextField();
			input.type = TextFieldType.INPUT;
			input.background = true;
			addChild(input);
			_width = TextInput.WIDTH;
			_height = TextInput.HEIGHT;
		}
		
		override public function updateUI():void {
			input.width = _width;
			input.height = _height;
			super.updateUI();
		}
		
		public function get text():String {
			return input.text;
		}
	}
}