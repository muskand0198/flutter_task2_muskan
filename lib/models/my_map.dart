import 'my_data.dart';

class MyMap{
  final Map<MyData, List<MyData>> _map = {};

  Map<MyData, List<MyData>> get map => _map;

  void updateMap(MyData element, List<MyData> json) {
    for (var item in json) {
      if (element.categoryId == item.parentID) {
        _map.putIfAbsent(element, () => []);
        _map[element]!.add(item);
      }
    }
  }

  void mapData(List<MyData> list) {
    for (var item in list) {
      if (item.parentID == "0") {
        _map[item] ??= [];
      }
    }
  }
}