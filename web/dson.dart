library serialise.dson;

import 'package:dson/dson.dart';


@serializable
class Simple
{
	String id;
	double value;
	bool flag;
}


@serializable
class Complex
{
	Simple simple;
	List<Simple> list;
}


void main()
{
	var complex = fromJson('''{
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
	}''', Complex);

	print(complex.simple.id);
	print(toJson(complex));
}
