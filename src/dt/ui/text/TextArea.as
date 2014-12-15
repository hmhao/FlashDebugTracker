package dt.ui.text {
	import dt.ui.UIComponent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.StyleSheet;
	/**
	 * ...
	 * @author hmh
	 */
	public class TextArea extends UIComponent {
		protected var outputText:TextField;//普通面板，显示所有记录
		protected var outputHtmlText:TextField;//搜索结果面板，显示搜索到的记录
		protected var _htmlText:String;//搜索结果
		
		public function TextArea() {
			createText();
			createHtmlText();
			//addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		protected function createText():void {
			outputText = new TextField();
			outputText.background = false;
			outputText.border = true;
			outputText.wordWrap = true;
			outputText.selectable = true;
			outputText.borderColor = 0x666666;
			var tf:TextFormat = new TextFormat();
			tf.color = 0x666666;
			outputText.defaultTextFormat = tf;
			addChild(outputText);
		}
		
		protected function createHtmlText():void {
			var style:StyleSheet = new StyleSheet();
			style.parseCSS("body{color:#666666;}");
			outputHtmlText = new TextField();
			outputHtmlText.styleSheet = style;
			outputHtmlText.background = false;
			outputHtmlText.border = true;
			outputHtmlText.wordWrap = true;
			outputHtmlText.selectable = true;
			outputHtmlText.borderColor = 0x666666;
			outputHtmlText.visible = false;
			addChild(outputHtmlText);
		}
		
		override public function updateUI():void {	
			outputText.width = _width;
			outputHtmlText.width = _width;
			outputText.height = _height;
			outputHtmlText.height = _height;
			super.updateUI();
		}
		
		public function get htmlText():String {
			return _htmlText;
		}
		
		public function set htmlText(value:String):void {
			_htmlText = value;
			outputHtmlText.htmlText = "<body>"+_htmlText+"</body>";
		}
		
		public function get text():String {
			return outputText.text;
		}
		
		public function set text(value:String):void {
			outputText.text = value;
		}
		
		public function appendHtmlText(value:String):void {
			if (value != "") {
				htmlText += value;
			}
		}
		
		public function appendText(value:String):void {
			outputText.appendText(value);
		}
		
		public function showHtmlText(flag:Boolean):void {
			outputHtmlText.visible = flag;
			outputText.visible = !flag;
		}
		
		public function clear():void {
			htmlText = "";
			text = "";
		}
		
		protected function onFrame(event:Event):void {
			outputHtmlText.scrollV = outputHtmlText.maxScrollV;
			outputText.scrollV = outputText.maxScrollV;
		}
	}
}