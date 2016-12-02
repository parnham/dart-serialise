Object serialisation in Dart
============================

I have been using [Dart](https://www.dartlang.org/) for a few years now, specifically to produce a complex front-end for our machine vision framework. A recurring theme 
with browser-based applications is the use of JSON to communicate with server-side daemons and the "dart:convert" core package provides reliable 
serialisation/deserialisation capabilities. But one thing Dart cannot do, and I believe it was a mistake to not bake in this ability from the 
beginning, is to support native serialisation/deserialisation of Dart objects.

There have been numerous third-party packages over the years that attempt to address this issue, in fact I dabbled with the mirrors system 
early on and produced [model_map](http://pub.dartlang.org/packages/model_map), but at the time reflection-based code did not compile to javascript properly.

As far as I can tell, the only viable options today are reflection/transformer based solutions and manual serialisation code. I would like to 
propose a third possibility based on the recent javascript interop capabilities of the [js package](https://pub.dartlang.org/packages/js).

---
Manual
------

This method involves writing functions that convert your entity to/from maps which can then be serialised using the core "dart:convert" 
library. If your application contains many complex entities, this means writing an awful lot of boilerplate code and introduces many places 
in which mistakes can be easily made.

```dart
import 'dart:convert';

class Simple
{
    String id;
    double value;
    bool flag;

    static Simple deserialise(dynamic m)
    {
        return m == null ? null : new Simple()
            ..id    = m['id']
            ..value = m['value']?.toDouble() ?? 0.0
            ..flag  = m['flag'] ?? false
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
```

which can be encoded and decoded from JSON as follows 

```dart
// Deserialise
var simple = Simple.deserialise(JSON.decode(data));

// Serialise
JSON.encode(simple.serialise());
```

---
Reflection and Transformers
---------------------------

An alternative is to use a library that has different behaviours depending on whether you are running in a Dart VM or compiled javascript.

If running in a Dart VM (either command-line or Dartium) then it uses reflection to serialise the class fields. When compiled to javascript 
a transformer is used to generate serialisation/deserialisation code without the need for runtime reflection.

The example provided here is based on the [DSON package](https://pub.dartlang.org/packages/dson). This method results in the least amount of 
boilerplate and is quite an elegant solution considering that object serialisation is not supported natively within Dart.

```dart
@serializable
class Simple
{
    String id;
    double value;
    bool flag;
}
```

which can be encoded and decoded from JSON as follows

```dart
// Deserialise
var simple = fromJson(data, Simple);

// Serialise
toJson(simple);
```

---
Interop Proposal
----------------

The recent development of the [javascript interop package](https://pub.dartlang.org/packages/js) has provided the fundamentals 
for an alternative method of object serialisation.

_Caveat: This method is based on javascript interop and is therefore only of use in browser-based applications. For shared Dart 
entities between the browser and server-side you should use one of the previously mentioned solutions._

A prerequisite of the interop method is to provide direct access to the javascript serialisation functions.

```dart
@JS()
library serialise.interop;

import 'package:js/js.dart';

@JS('JSON.parse')
external dynamic fromJson(String text);

@JS('JSON.stringify')
external String toJson(dynamic object);
```

An entity can then be declared as an anonymous javascript object:

```dart
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
```

which can be encoded and decoded from JSON as follows

```dart
// Deserialise
Simple simple = fromJson(data);

// Serialise
toJson(simple);
```

Due to the limitations of interop, fields can not be used and getter/setter functions must be declared instead. 
This results in more boilerplate than the reflection method, but still less than the manual method and with a reduced 
chance of introducing errors.

---
Comparison
----------

The following comparisons of size and speed were produced using the code in this repository and Dart v1.20.1, DSON v0.3.4, 
js v0.6.1, Dartium 45.0.2454.104 and Chrome 54.0.2840.100.

The full results can be found in the [results](results/results.ods) spreadsheet. Each row in the spreadsheet represents 1000 
iterations of serialisation and 1000 iterations of deserialisation of a non-trivial entity. The numbers shown here are averages
and ignore the first half-dozen runs. 

| Method  | Size (js) | Serialise (dart) | Deserialise (dart) | Serialise (js) | Deserialise (js) |
| ------- | --------- | ---------------- | ------------------ | -------------- | ---------------- |
| Manual  | 38.8 KB   | 4.9 µs           | 3.2 µs             | 10.4 µs        | 6.5 µs           |
| DSON    | 115.1 KB  | 101.2  µs        | 57.6 µs            | 2414.9 µs      | 938.8 µs         |
| Interop | 32.9 KB   | 100.4 µs         | 28.4 µs            | 3.7 µs         | 3.5 µs           |

The manual method running in the DartVM was the fastest overall, but the interop method is clearly the
winner when compiled to javascript. What was surprising is how much slower the DSON method is when compiled.
The interop method also resulted in the smallest javascript file size.

---
Conclusions
-----------

We have already started using the interop method in our applications since it is more efficient and less prone to error
than the manual method, and whilst not as terse as the DSON method it is faster overall.

If you do not care about creating or modifying an entity such as a read-only entity that is only ever deserialised in the front-end
then you can drop the setters and factory:

```dart
@JS()
@anonymous
class Simple
{
    external String get id;
    external double get value;
    external bool get flag;
}
```

Something to be aware of is that items that do not exist in the JSON will result in ```null``` values in the entity.
