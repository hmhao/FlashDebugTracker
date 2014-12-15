package dt.utils{
	import flash.display.*;
	import flash.text.*;
	
	public class TextSearchEngine {
		public static const STACK:String = "Stack";
		public static var datas:Array = [];
		public static var stacks:Array = [];
		public static var isSearch:Boolean = false;
		public static var isFilterStack:Boolean = false;//是否过滤堆栈信息
		public static var searchText:String;//搜索指定的字段
		
		private static var reg:RegExp;//正则表达式
		private static var strongReg:String = "<font color='#ff0000'>$&</font>";
		private static var escapeReg:RegExp = /[\[\]().+*^#$|\\]/gi;//匹配正则转义字符
		private static var ltReg:RegExp = /<(?!\/?font)/gi;//匹配右侧不出现[/]font的所有<
		private static var gtReg:RegExp = /(?<!'|\/font)>/gi;//匹配左侧不出现/font或'的所有>
		/**
		 * 
		 * @param	text
		 * @param	arr
		 * @return	{
		 * 				text:结果, 
		 * 				showAll:标记是否显示全部或结果集
		 * 			}
		 * 
		 * 			text = ''时, showAll = true;
		 * 			text != ''时, showAll = false;
		 */
		public static function findExact(text:String, arr:Array = null):Object {
			var result:Object = { };
			if (arr == null) {
				arr = isFilterStack ? stacks : datas.concat(stacks).sort();
			}
			if (/^\s*$/.test(text)) {
				searchText = "";
				result.text = filter(arr).join("");
				result.showAll = true;
				isSearch = false;
			}else{
				searchText = text.replace(escapeReg,"\\$&");//对搜索的字串在符合正则转义字符前加上\,构成非转义字符
				var match:Array = filter(arr);
				if (match.length > 0) {
					result.text = match.join("");
					result.text = strongText(result.text, text);
				}else {
					result.text = "";
				}
				result.showAll = false;
				isSearch = true;
			}
			return result;
		}
		/**
		 * 突出字体
		 * @param	text
		 * @param	pattern
		 * @return	
		 */
		private static function strongText(text:String, pattern:String):String {
			return text.replace(reg, strongReg).replace(ltReg,"&lt;").replace(gtReg,"&gt;");
			//return text.split(pattern).join("<font color='#ff0000'>" + pattern + "</font>");
		}
		/**
		 * 过滤指定数组
		 * 在指定数组中过滤堆栈信息，则调用filterStackFun
		 * 否则调用filterFun
		 * @param	arr
		 * @return
		 */
		private static function filter(arr:Array):Array {
			reg = new RegExp(searchText, "gi");
			if (isFilterStack){
				return arr.filter(filterFun);
			}else{
				return arr.filter(filterFun);
			}
		}
		/**
		 * 普通过滤，过滤指定的搜索字段
		 * @param	t
		 * @param	index
		 * @param	arr
		 * @return
		 */
		private static function filterFun(t:String, index:int, arr:Array):Boolean {
			reg.lastIndex = 0;
			if (reg.test(t) && (isFilterStack ? t.indexOf(STACK) != -1 : true)) {//这样写可以不用filterStackFun
			//if (reg.test(t)) {
				return true;
			}else{
				return false;
			}
		}
		/**
		 * 堆栈信息过滤，在堆栈信息中过滤指定的搜索字段
		 * @param	t
		 * @param	index
		 * @param	arr
		 * @return
		 */
		private static function filterStackFun(t:String, index:int, arr:Array):Boolean {
			reg.lastIndex = 0;
			if (t.indexOf(STACK) != -1 && reg.test(t)) {
				return true;
			}else{
				return false;
			}
		}
	}
}
