package dt.utils {
	import flash.net.LocalConnection;
	import flash.events.StatusEvent;
	
	/**
	 * ...
	 * @author hmh
	 */
	public class StackTrace {
		
		private static var conn:LocalConnection;
		
		protected static function sendLoaclMsg(text:*):void {
			var _conn:LocalConnection = init();
			_conn.send("_myConnection", "lcHandler", text);
		}
		
		protected static function sendStackMsg(text:*):void {
			var _conn:LocalConnection = init();
			_conn.send("_myConnection", "lcStackHandler", text);
		}
		
		public static function send(text:*):void {
			var error:Error = new Error()
			var stackTrace:String = error.getStackTrace();
			stackTrace = stackTrace.replace(/^Error\s*.*/,"Stack:");
			try {
				sendStackMsg(text + " >> " +stackTrace);
			} catch (e:Error) {}
		}
		
		private static function init():LocalConnection {
			if (conn) {
				return conn;
			} else {
				conn = new LocalConnection();
				conn.addEventListener(StatusEvent.STATUS, onStatus);
				return conn;
			}
		}
		
		private static function onStatus(event:StatusEvent):void {
			switch (event.level) {
				case "status":
					break;
				case "error":
					break;
			}
		}
	}
}