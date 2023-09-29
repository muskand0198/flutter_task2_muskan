import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_task2_muskan/models/my_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'load_json_provider.g.dart';

@riverpod
class JsonNotifier extends _$JsonNotifier {
  @override
  FutureOr<List<MyData>?> build() {
    return null;
  }

  Future<List<MyData>?> loadDataFromAssets() async {
    state = const AsyncValue.loading();
    final data = await rootBundle.loadString("assets/data.json");

    final jsonData = jsonDecode(data) as List<dynamic>;
    final list = jsonData.map((e) => MyData.fromJson(e)).toList();
    state = AsyncValue.data(list);
    return list;
  }
}
