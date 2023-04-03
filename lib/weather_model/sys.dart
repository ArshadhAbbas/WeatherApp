import 'package:json_annotation/json_annotation.dart';

part 'sys.g.dart';

@JsonSerializable()
class Sys {
  @JsonKey(name: "country")
	String? country;
  @JsonKey(name: "sunrise")
	int? sunrise;
  @JsonKey(name: "sunset")
	int? sunset;

	Sys({this.country, this.sunrise, this.sunset});

	factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

	Map<String, dynamic> toJson() => _$SysToJson(this);
}
