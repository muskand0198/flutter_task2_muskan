import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task2_muskan/models/my_map.dart';
import 'package:flutter_task2_muskan/screen/components/custom_card.dart';
import '../providers/load_json_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    MyMap resultantMap = MyMap();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Task 2",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: response.when(data: (data) {
          if (data != null) {
            resultantMap.mapData(data);
            resultantMap.map.keys.forEach((element) {
              resultantMap.updateMap(element, data);
            });

            return ListView.builder(
                itemCount: resultantMap.map.keys.length,
                itemBuilder: (BuildContext context, int index) {
                  var element = resultantMap.map.entries.elementAt(index);
                  return ExpansionTile(
                    title: CustomCard(
                      slug: element.key.slug,
                      date: element.key.createDate,
                      description: element.key.description,
                      isParent: true,
                    ),
                    children: element.value.map((e) {
                      return CustomCard(
                        slug: e.slug,
                        date: e.createDate,
                        description: e.description,
                        isParent: false,
                      );
                    }).toList(),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }, error: (e, s) {
          return null;
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
