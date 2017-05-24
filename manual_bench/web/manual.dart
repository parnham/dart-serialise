library serialise.manual;

import 'dart:convert';
// import 'dart:html';

class Simple
{
	String id;
	double value;
	bool flag;


	static Simple deserialise(dynamic m)
	{
		return m == null ? null : new Simple()
			..id	= m['id']
			..value	= m['value']?.toDouble() ?? 0.0
			..flag	= m['flag'] ?? false
		;
	}

	Map serialise()
	{
		return {
			'id': id,
			'value': value,
			'flag': flag
		};
	}
}


class Complex
{
	Simple simple;
	List<Simple> list;


	static Complex deserialise(dynamic m)
	{
		return m == null ? null : new Complex()
			..simple = Simple.deserialise(m['simple'])
			..list = m['list']?.map((l) => Simple.deserialise(l))?.toList()
		;
	}

	Map serialise()
	{
		return {
			'simple': simple?.serialise(),
			'list': list?.map((l) => l.serialise())?.toList()
		};
	}
}


void main()
{
	var complex = Complex.deserialise(JSON.decode('''{
		"simple": {
			"id": "something",
			"value": 42.0,
			"flag": true
		},
		"list": [
			{"id":"item 0","value":0,"flag":true},
			{"id":"item 1","value":1,"flag":false},
			{"id":"item 2","value":2,"flag":true}
		]
	}'''));

	print(complex.simple.id);
	print(JSON.encode(complex.serialise()));
}
