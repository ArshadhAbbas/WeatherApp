import 'package:json_annotation/json_annotation.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  @JsonKey(name: "coord")
  Coord? coord;

  @JsonKey(name: "weather")
  List<Weather>? weather;

  @JsonKey(name: "base")
  String? base;

  @JsonKey(name: "main")
  Main? main;

  @JsonKey(name: "visibility")
  int? visibility;

  @JsonKey(name: "wind")
  Wind? wind;

  @JsonKey(name: "clouds")
  Clouds? clouds;

  @JsonKey(name: "dt")
  int? dt;

  @JsonKey(name: "sys")
  Sys? sys;

  @JsonKey(name: "timezone")
  int? timezone;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "cod")
  int? cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
