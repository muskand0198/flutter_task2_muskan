import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_data.freezed.dart';

part 'my_data.g.dart';

@freezed
class MyData with _$MyData {
  const MyData._();

  const factory MyData(
      {required String categoryId,
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
      @JsonKey(name: "create_date") required String createDate,
      List<MyData>? children}) = _MyData;

  factory MyData.fromJson(Map<String, dynamic> json) => _$MyDataFromJson(json);

  static List<MyData> mapData(List<MyData> list) {
    Map<String, List<MyData>> parentMap = {};

    for (MyData data in list) {
      if (data.parentID == '0') {
        parentMap[data.categoryId] = [];
      } else {
        parentMap[data.parentID]?.add(data);
      }
    }

    List<MyData> result = [];
    parentMap.forEach((parentId, children) {
      MyData parent = list.firstWhere((data) => data.categoryId == parentId);
      result.add(parent.copyWith(children: children));
    });

    return result;
  }

  String getSlug(String language) {
    if (language == "hi" && name != null) {
      return name![1]['value'];
    } else if (name != null) {
      return name![0]['value'];
    } else {
      return "";
    }
  }
}
