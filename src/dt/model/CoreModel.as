package dt.model {
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author hmh
	 */
	public class CoreModel extends EventDispatcher {
		private var _acceptMessage:Boolean = true;//接收信息
		private var _filterStack:Boolean = false;//过滤堆栈信息
		
		public function CoreModel() {
		
		}
		
		public function get acceptMessage():Boolean {
			return _acceptMessage;
		}
		
		public function set acceptMessage(value:Boolean):void {
			_acceptMessage = value;
		}
		
		public function get filterStack():Boolean {
			return _filterStack;
		}
		
		public function set filterStack(value:Boolean):void {
			_filterStack = value;
		}
	
	}

}