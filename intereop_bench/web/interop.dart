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

	external List<int> get numbers;
	external set numbers(List<int> numbers);

	external factory Complex({
		Simple simple,
		List<Simple> list,
		List<int> numbers
	});
}


void main()
{
	Complex complex = fromJson('''{
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
	}''');

	print(complex.simple.id);
	print(toJson(complex));
}

