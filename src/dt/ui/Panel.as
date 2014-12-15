package dt.ui {
	import dt.model.CoreModel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import dt.ui.button.*;
	import dt.ui.text.*;
	import dt.utils.TextSearchEngine;
	
	/**
	 * ...
	 * @author hmh
	 */
	public class Panel extends UIComponent {
		private var _model:CoreModel;
		protected var output:TextArea; //显示面板
		protected var clearBtn:Button;
		protected var acceptBtn:ToggleButton;
		protected var stackBtn:ToggleButton;
		protected var searchInput:TextInput; //搜索栏
		protected var margin:Number = 2;
		protected var prevsearchInput:String; //记录前一次搜索的字段
		
		public function Panel(model:CoreModel) {
			_model = model;
			clearBtn = new Button("Clear Up");
			acceptBtn = new ToggleButton("Accept");
			stackBtn = new ToggleButton("Stack");
			searchInput = new TextInput();
			output = new TextArea();
			addChild(clearBtn);
			addChild(acceptBtn);
			addChild(stackBtn);
			addChild(searchInput);
			addChild(output);
		}
		
		override protected function init(e:Event = null):void {
			super.init();
			acceptBtn.status = _model.acceptMessage;
			stackBtn.status = _model.filterStack;
			clearBtn.addEventListener(MouseEvent.CLICK, clearBtnHandler);
			acceptBtn.addEventListener(MouseEvent.CLICK, acceptBtnHandler);
			stackBtn.addEventListener(MouseEvent.CLICK, stackBtnHandler);
			searchInput.addEventListener(KeyboardEvent.KEY_UP, doSearch);
		}
		
		override public function updateUI():void {
			clearBtn.width = 60;
			clearBtn.x = 2;
			clearBtn.y = 3;
			
			acceptBtn.width = 40;
			acceptBtn.x = clearBtn.x + clearBtn.width + 2;
			acceptBtn.y = clearBtn.y;
			
			stackBtn.width = 40;
			stackBtn.x = this.width - stackBtn.width - 2;
			stackBtn.y = clearBtn.y
			
			searchInput.width = this.width - clearBtn.width - stackBtn.width - acceptBtn.width - 5 * margin;
			searchInput.x = acceptBtn.x + acceptBtn.width + margin;
			searchInput.y = acceptBtn.y;
			
			output.width = this.width - 2;
			output.height = this.height - 40;
			output.x = 0;
			output.y = clearBtn.y + clearBtn.height;
			super.updateUI();
		}
		/**
		 * 搜索处理
		 * @param	event
		 */
		protected function doSearch(event:KeyboardEvent = null):void {
			var t:String = searchInput.text;
			if (t != prevsearchInput || event == null) {
				prevsearchInput = t;
				var find:Object = TextSearchEngine.findExact(t);
				if (find.showAll){//显示普通
					output.text = find.text;
				}else{//显示搜索面板
					output.htmlText = find.text;
				}
				output.showHtmlText(!find.showAll);
			}
		}
		
		protected function clearBtnHandler(event:MouseEvent):void {
			TextSearchEngine.datas.length = 0;
			TextSearchEngine.stacks.length = 0;
			output.clear();
		}
		
		protected function acceptBtnHandler(event:MouseEvent):void {
			_model.acceptMessage = !_model.acceptMessage;
			acceptBtn.status = _model.acceptMessage;
		}
		
		protected function stackBtnHandler(event:MouseEvent):void {
			_model.filterStack = !_model.filterStack;
			stackBtn.status = _model.filterStack;
			TextSearchEngine.isFilterStack = _model.filterStack;
			doSearch();
		}
		/**
		 * 想ouput面板加入记录
		 * @param	text
		 */
		public function appendText(text:String):void {
			var find:Object;
			//普通面板处理
			if (TextSearchEngine.isFilterStack) {//如果需要过滤堆栈信息
				find = TextSearchEngine.findExact(TextSearchEngine.searchText, [text]);
				output.appendText(find.text);
			}else{//否则直接插入
				output.appendText(text);
			}
			//搜索结果面板处理
			if (TextSearchEngine.isSearch) { //如果处于搜索状态，则需要过滤是否加入
				find = TextSearchEngine.findExact(TextSearchEngine.searchText, [text]);
				output.appendHtmlText(find.text);
			}
		}
	}
}