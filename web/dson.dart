library serialise.dson;

import 'package:dson/dson.dart';

part 'dson.g.dart';


@serializable
class Simple extends _$SimpleSerializable
{
	String id;
	double value;
	bool flag;
}


@serializable
class Complex extends _$ComplexSerializable
{
	Simple simple;
	List<Simple> list;
}


void main()
{
	_initMirrors();

	var complex = fromJson('''{
		"simple": {
			"id": "something",
			"value": 42.0,
			"flag": true
		},
		"list": [
			{"id":"item 0","value":0.0,"flag":true},
			{"id":"item 1","value":1.0,"flag":false},
			{"id":"item 2","value":2.0,"flag":true}
		]
	}''', Complex);

	print(complex.simple.id);
	print(toJson(complex));
}
