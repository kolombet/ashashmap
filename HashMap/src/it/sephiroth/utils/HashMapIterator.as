package it.sephiroth.utils
{
	import it.sephiroth.utils.collections.iterators.Iterator;

	public class HashMapIterator implements Iterator
	{
		protected var _current: Entry;
		protected var _index: int = 0;
		protected var _map: HashMap;
		protected var _next: Entry;
		protected var _lenght: int;

		public function HashMapIterator( map: HashMap )
		{
			_map = map;
			_lenght = map.table.length;

			if ( _map.size() > 0 )
			{
				while ( _index < _lenght && ( _next = _map.table[ _index++ ] ) == null ){}
			}
		}

		public function hasNext(): Boolean
		{
			return _next != null;
		}

		protected function nextEntry(): Entry
		{
			var e: Entry = _next;
			if( e == null )
				throw new Error();
			
			if(( _next = e.next ) == null )
			{
				while ( _index < _lenght && ( _next = _map.table[ _index++ ] ) == null ){}
			}
			_current = e;
			return e;
		}
		
		public function next(): *
		{
			return nextEntry();
		}
	}
}