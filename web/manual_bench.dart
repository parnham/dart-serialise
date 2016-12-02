library serialise.manual;

import 'dart:convert';


class Simple
{
	String id;
	double value;
	bool flag;

	Simple({
		this.id,
		this.value,
		this.flag
	});

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

	Complex({
		this.simple,
		this.list
	});

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
	String data = '''{
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
	}''';


	for (int j=0; j<50; j++)
	{
		var s = new Stopwatch()..start();

		for (int i=0; i<1000; i++)
		{
			var complex = new Complex(
				list: [
					new Simple(id: "item 0", value: 0.0, flag: true),
					new Simple(id: "item 1", value: 1.0, flag: false ),
					new Simple(id: "item 2", value: 2.0, flag: true )
				],
				simple: new Simple(id: "something", value: 42.0, flag:true)
			);

			JSON.encode(complex.serialise());
		}

		s.stop();

		int forward = s.elapsedMicroseconds;

		s..reset()..start();

		for (int i=0; i<1000; i++)
		{
			Complex.deserialise(JSON.decode(data));
		}

		s.stop();

		print("$forward\t${s.elapsedMicroseconds}");
	}
}
