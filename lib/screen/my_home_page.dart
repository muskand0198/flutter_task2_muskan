import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task2_muskan/screen/components/custom_card.dart';
import '../models/my_data.dart';
import '../providers/load_json_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Map<MyData, List<MyData>> resultantMap;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(jsonNotifierProvider.notifier).loadDataFromAssets();
    });
  }

  @override
  void dispose() {
    super.dispose();
    ref.invalidate(jsonNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(jsonNotifierProvider);
    resultantMap = {};
    // int count = 0;
    // final list = ref.read(jsonProvider).list;

    // print("The output is $list");
    // final resultMap = mapData(list);
    // print("The map output is $resultMap");

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Task 2",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: response.when(data: (data) {
          // print("The size of map here1 is ${resultantMap.length}");
          if (data != null) {
            // print("The size of map here2 is ${resultantMap.length}");
            mapData(data);
            resultantMap.keys.forEach((element) {
              updateMap(element, data);
            });
            // print("The size of map here3 is ${resultantMap.length}");
            // print("The output is $resultantMap");
            // print("The size of map is ${resultantMap.length}");

            return SingleChildScrollView(
              child: Column(
                children: resultantMap.entries.map((element) {
                  // count++;
                  // print("The element is $element");
                  return ExpansionTile(
                    title: CustomCard(
                      slug: element.key.slug,
                      date: element.key.createDate,
                      description: element.key.description,
                      isParent: true,
                    ),
                    children: element.value.map((e) {
                      // count++;
                      // print("The value is $e");
                      // print("Total elements $count");
                      return CustomCard(
                        slug: e.slug,
                        date: e.createDate,
                        description: e.description,
                        isParent: false,
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator());
          }
        }, error: (e, s) {
          return null;
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }

  void mapData(List<MyData> list) {
    // Map<MyData, List<dynamic>> resultMap = {};
    for (var item in list) {
      if (item.parentID == "0") {
        resultantMap[item] ??= [];
      }
    }
  }

  void updateMap(MyData element, List<MyData> json) {
    for (var item in json) {
      if (element.categoryId == item.parentID) {
        resultantMap.putIfAbsent(element, () => []);
        resultantMap[element]!.add(item);
      }
    }
  }

// Widget buildTree(){
//
// }
}
