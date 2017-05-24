// GENERATED CODE - DO NOT MODIFY BY HAND

part of serialise.dson;

// **************************************************************************
// Generator: InitMirrorsGenerator
// Target: library serialise.dson
// **************************************************************************

_initMirrors() {
  initClassMirrors({Simple: SimpleClassMirror, Complex: ComplexClassMirror});
  initFunctionMirrors({});
}

// **************************************************************************
// Generator: DsonGenerator
// Target: class Simple
// **************************************************************************

abstract class _$SimpleSerializable extends SerializableMap {
  String get id;
  double get value;
  bool get flag;
  void set id(String v);
  void set value(double v);
  void set flag(bool v);

  operator [](Object key) {
    switch (key) {
      case 'id':
        return id;
      case 'value':
        return value;
      case 'flag':
        return flag;
    }
    throwFieldNotFoundException(key, 'Simple');
  }

  operator []=(Object key, value) {
    switch (key) {
      case 'id':
        id = value;
        return;
      case 'value':
        value = value;
        return;
      case 'flag':
        flag = value;
        return;
    }
    throwFieldNotFoundException(key, 'Simple');
  }

  Iterable<String> get keys => SimpleClassMirror.fields.keys;
}

_Simple__Constructor(params) => new Simple();

const $$Simple_fields_id = const DeclarationMirror(type: String);
const $$Simple_fields_value = const DeclarationMirror(type: double);
const $$Simple_fields_flag = const DeclarationMirror(type: bool);

const SimpleClassMirror =
    const ClassMirror(name: 'Simple', constructors: const {
  '': const FunctionMirror(parameters: const {}, call: _Simple__Constructor)
}, fields: const {
  'id': $$Simple_fields_id,
  'value': $$Simple_fields_value,
  'flag': $$Simple_fields_flag
}, getters: const [
  'id',
  'value',
  'flag'
], setters: const [
  'id',
  'value',
  'flag'
]);

// **************************************************************************
// Generator: DsonGenerator
// Target: class Complex
// **************************************************************************

abstract class _$ComplexSerializable extends SerializableMap {
  Simple get simple;
  List<Simple> get list;
  void set simple(Simple v);
  void set list(List<Simple> v);

  operator [](Object key) {
    switch (key) {
      case 'simple':
        return simple;
      case 'list':
        return list;
    }
    throwFieldNotFoundException(key, 'Complex');
  }

  operator []=(Object key, value) {
    switch (key) {
      case 'simple':
        simple = value;
        return;
      case 'list':
        list = value;
        return;
    }
    throwFieldNotFoundException(key, 'Complex');
  }

  Iterable<String> get keys => ComplexClassMirror.fields.keys;
}

_Complex__Constructor(params) => new Complex();

const $$Complex_fields_simple = const DeclarationMirror(type: Simple);
const $$Complex_fields_list =
    const DeclarationMirror(type: const [List, Simple]);

const ComplexClassMirror =
    const ClassMirror(name: 'Complex', constructors: const {
  '': const FunctionMirror(parameters: const {}, call: _Complex__Constructor)
}, fields: const {
  'simple': $$Complex_fields_simple,
  'list': $$Complex_fields_list
}, getters: const [
  'simple',
  'list'
], setters: const [
  'simple',
  'list'
]);
