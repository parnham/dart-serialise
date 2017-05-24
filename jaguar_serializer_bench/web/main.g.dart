// GENERATED CODE - DO NOT MODIFY BY HAND

part of serialise.jaguar_serializer_bench;

// **************************************************************************
// Generator: SerializerGenerator
// Target: class SimpleJsonSerializer
// **************************************************************************

abstract class _$SimpleJsonSerializer implements Serializer<Simple> {
  Map toMap(Simple model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
      }
      if (model.value != null) {
        ret["value"] = model.value;
      }
      if (model.flag != null) {
        ret["flag"] = model.flag;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Simple fromMap(Map map, {Simple model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Simple) {
      model = createModel();
    }
    model.id = map["id"];
    model.value = map["value"];
    model.flag = map["flag"];
    return model;
  }

  String modelString() => "Simple";
}

// **************************************************************************
// Generator: SerializerGenerator
// Target: class ComplexJsonSerializer
// **************************************************************************

abstract class _$ComplexJsonSerializer implements Serializer<Complex> {
  final SimpleJsonSerializer toSimpleJsonSerializer =
      new SimpleJsonSerializer();
  final SimpleJsonSerializer fromSimpleJsonSerializer =
      new SimpleJsonSerializer();

  Map toMap(Complex model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.simple != null) {
        ret["simple"] = toSimpleJsonSerializer.toMap(model.simple,
            withType: withType, typeKey: typeKey);
      }
      if (model.list != null) {
        ret["list"] = model.list
            ?.map((Simple val) => val != null
                ? toSimpleJsonSerializer.toMap(val,
                    withType: withType, typeKey: typeKey)
                : null)
            ?.toList();
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  Complex fromMap(Map map, {Complex model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! Complex) {
      model = createModel();
    }
    model.simple =
        fromSimpleJsonSerializer.fromMap(map["simple"], typeKey: typeKey);
    model.list = map["list"]
        ?.map((Map val) =>
            fromSimpleJsonSerializer.fromMap(val, typeKey: typeKey))
        ?.toList();
    return model;
  }

  String modelString() => "Complex";
}
