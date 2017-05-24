@JS()
library serialise.interop;

import 'package:js/js.dart';


@JS('JSON.parse')
external dynamic fromJson(String text);

@JS('JSON.stringify')
external String toJson(dynamic object);


@JS()
@anonymous
class Simple
{
	external String get id;
	external set id(String value);

	external double get value;
	external set value(double value);

	external bool get flag;
	external set flag(bool value);

	external factory Simple({
		String id,
		double value,
		bool flag
	});
}


@JS()
@anonymous
class Complex
{
	external Simple get simple;
	external set simple(Simple value);

	external List<Simple> get list;
	external set list(List<Simple> value);

	external factory Complex({
		Simple simple,
		List<Simple> list
	});
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

			toJson(complex);
		}

		s.stop();

		int forward = s.elapsedMicroseconds;

		s..reset()..start();

		for (int i=0; i<1000; i++)
		{
			fromJson(data);
		}

		s.stop();

		print("$forward\t${s.elapsedMicroseconds}");
	}
}
