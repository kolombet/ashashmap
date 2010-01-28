package it.sephiroth.utils
{
	import it.sephiroth.utils.collections.iterators.Iterator;

	public class EntrySet
	{
		private var _map: HashMap;
		public static const MAX_VALUE: int = uint(-1);
		
		public function EntrySet( map: HashMap )
		{
			_map = map;
		}
			
		public function iterator(): Iterator
		{
			return new EntrySetIterator( _map );
		}
		
		public function toArray( a: Vector.<Object> ): Vector.<Object>
		{
			var size: int = _map.size();
			var r: Vector.<Object> = a.length >= size ? a : new Vector.<Object>(size);
			var i: Iterator = iterator();
			
			for( var k: int = 0; k < r.length; k++ )
			{
				if(! i.hasNext())
				{
					if( a != r )
					{
						r.length = k;
						return r;
					}
					r[k] = null;
					return r;
				}
				r[k] = i.next();
			}
			return i.hasNext() ? finishToArray(r, i) : r;
		}
		
		private static function finishToArray( r: Vector.<Object>, i: Iterator ): Vector.<Object>
		{
			var k: int = r.length;
			while (i.hasNext()) 
			{
				var cap: int = r.length;
				if( k == cap )
				{
					var newCap: int = ((cap / 2) + 1) * 3;
					if (newCap <= cap)
					{
						if (cap ==  MAX_VALUE )
							throw new RangeError("Required array size too large");
						newCap = MAX_VALUE;
					}
					r.length = newCap;
				}
				r[k++] = i.next();
			}
			
			if( k == r.length )
			{
				return r;
			} else
			{
				r.length = k;
				return r;
			}
		}
	}
}