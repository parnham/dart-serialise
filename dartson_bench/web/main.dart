library serialise.dartson_bench;

import 'dart:html';
import 'package:dartson/dartson.dart';

@Entity()
class Simple {
	String id;
	double value;
	bool flag;
}

@Entity()
class Complex {
	Simple simple;
	List<Simple> list;
}

void main() {
	var output = document.querySelector('#output');

	String data = '''{
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
	}''';

	int serializeTimeTotal = 0;
	int deserializeTimeTotal = 0;

	var serializer = new Dartson.JSON();

	for (int j=0; j<50; j++) {
		var s = new Stopwatch()..start();

		for (int i=0; i<1000; i++) {
			var complex = new Complex()
				..list = [
					new Simple()..id = "item 0"..value = 0.0..flag = true,
					new Simple()..id = "item 1"..value = 1.0..flag = false,
					new Simple()..id = "item 2"..value = 2.0..flag = true
				]
				..simple = (new Simple()..id = "something"..value = 42.0..flag = true);

			serializer.encode(complex);
		}

		s.stop();

		int serializeTime = s.elapsedMicroseconds;
		serializeTimeTotal += serializeTime;

		s..reset()..start();

		for (int i=0; i<1000; i++) {
			serializer.decode(data, new Complex());
		}

		s.stop();

		var deserializeTime = s.elapsedMicroseconds;
		deserializeTimeTotal += deserializeTime;

		output.appendHtml("<tr><td>$serializeTime</td><td>${deserializeTime}</td>");
	}

	output.appendHtml("<tr><th>${serializeTimeTotal/50}</th><th>${deserializeTimeTotal/50}</th></tr>");
}
