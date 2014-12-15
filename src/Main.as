package {
	import dt.model.CoreModel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.net.LocalConnection;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import dt.ui.Panel;
	import dt.ui.UIComponent;
	import dt.utils.TextSearchEngine;
	import dt.utils.StackTrace;
	import dt.menu.*;
	
	/**
	 * ...
	 * @author hmh
	 */
	public class Main extends Sprite {
		private var conn:LocalConnection;
		private var model:CoreModel;
		private var panel:Panel;
		
		public function Main():void {
			Security.allowDomain("*");
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			model = new CoreModel();
			panel = new Panel(model);
			addChild(panel);
			
			connectTracker();
			
			UIComponent.addMonitor(panel);
		}

		/**
		 * 开启同域接口通信器
		 */
		protected function connectTracker():void {
			conn = new LocalConnection();
			conn.allowDomain("*");
			conn.client = this;
			try {
				conn.connect("_myConnection");
			} catch (error:ArgumentError) {
				panel.appendText("Can\'t connect...the connection name is already being used by another SWF\n");
			}
		}
		
		/**
		 * 通信接口的方法
		 * @param	msg
		 */
		public function lcHandler(msg:String):void {
			if(model.acceptMessage){
				var text:String = getTime() + "------" + msg + "\n";
				TextSearchEngine.datas.push(text);
				panel.appendText(text);
			}
		}
		
		/**
		 * 通信接口的方法
		 * @param	msg
		 */
		public function lcStackHandler(msg:String):void {
			if(model.acceptMessage){
				var text:String = getTime() + "------" + msg + "\n";
				TextSearchEngine.stacks.push(text);
				panel.appendText(text);
			}
		}
		/**
		 * 获取格式化时间
		 * @return
		 */
		protected function getTime():String {
			var date:Date = new Date();
			var time:String = date.toTimeString().split(" ")[0] + ".";
			var milliseconds:String = date.getMilliseconds().toString();
			while (milliseconds.length < 3) {
				milliseconds += "0";
			}
			time += milliseconds;
			return time;
		}
	}
}