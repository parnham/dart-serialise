@JS()
library interop.test;

import 'package:js/js.dart';


@JS('JSON.parse')
external dynamic fromJson(String text);

@JS('JSON.stringify')
external String toJson(dynamic object);

@JS('console.log')
external void jsLog(dynamic object);


@JS()
@anonymous
class Simple
{
	external List<int> get numbers;
	external set numbers(List<int> numbers);

	external factory Simple({
		List<int> numbers
	});
}

void main()
{
	var simple = new Simple(numbers: [ 1, 2, 3 ]);
	print(toJson(simple));

	// Simple simple = fromJson('{"numbers":[1,2,3]}');

	// jsLog(simple);
	// jsLog(simple.numbers);
}
