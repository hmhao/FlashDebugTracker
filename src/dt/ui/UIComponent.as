package dt.ui {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hmh
	 */
	public class UIComponent extends Sprite {
		private static var _isInit:Boolean;
		private static var _view:UIComponent;
		private static var _stage:Stage;
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _isReady:Boolean;
		
		public function UIComponent() {
			if (stage) {
				init()
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		protected function init(event:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_isReady = true;
		}
		/**
		 * 渲染UI,查看容器内的实例，若是UIComponent类则递归执行updateUI
		 * UIComponent类应覆盖updateUI实现UI的渲染，例如大小，位置的变化
		 * override updateUI方法时，应将super.updateUI()放置方法的最后，实现递归更新
		 */
		public function updateUI():void {
			trace(this + "updateUI");
			var ui:DisplayObject;
			for (var i:int = 0; i < numChildren; i++ ) {
				ui = getChildAt(i);
				if (ui is UIComponent) {
					UIComponent(ui).updateUI();
				}
			}
		}
		
		override public function set width(value:Number):void {
			_width = value;
		}
		
		override public function get width():Number {
			return _width;
		}
		
		override public function set height(value:Number):void {
			_height = value;
		}
		
		override public function get height():Number {
			return _height;
		}
		
		public static function addMonitor(view:UIComponent):void {
			if (!_isInit) {
				_view = view;
				_stage = _view.stage;
				_stage.scaleMode = StageScaleMode.NO_SCALE;
				_stage.align = StageAlign.TOP_LEFT;
				_stage.showDefaultContextMenu = false;
				_stage.addEventListener(Event.RESIZE, onStageResize);
				onStageResize(null);
				_isInit = true;
			}
		}
		
		protected static function onStageResize(event:Event):void {
			_view.width = _stage.stageWidth;
			_view.height = _stage.stageHeight;
			_view.updateUI();
		}
	}
}