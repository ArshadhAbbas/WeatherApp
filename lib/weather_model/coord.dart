import 'package:json_annotation/json_annotation.dart';

part 'coord.g.dart';

@JsonSerializable()
class Coord {

  @JsonKey(name: "lon")
	double? lon;

  @JsonKey(name: "lat")
	double? lat;

	Coord({this.lon, this.lat});

	factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

	Map<String, dynamic> toJson() => _$CoordToJson(this);
}
