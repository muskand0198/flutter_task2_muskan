import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_data.freezed.dart';
part 'my_data.g.dart';

@freezed
class MyData with _$MyData{
  const factory MyData({
    required String categoryId,
    List<dynamic>? name,
    required String slug,
    required String description,
    required String parentID,
    int? type,
    String? attributeSet,
    int? categoryNumber,
    required int level,
    bool? featured,
    String? icon,
    List<dynamic>? image,
    bool? status,
    @JsonKey(name: "create_date")required String createDate

}) = _MyData;
  factory MyData.fromJson(Map<String, dynamic> json) => _$MyDataFromJson(json);
}