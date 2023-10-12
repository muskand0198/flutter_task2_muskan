import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task2_muskan/providers/locale_providers.dart';
import 'package:flutter_task2_muskan/screen/components/custom_card.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../models/my_data.dart';
import '../providers/load_json_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
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
    ref.invalidate(localeProvider);
    ref.invalidate(sharedPrefs);
  }

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(jsonNotifierProvider);
    final locale = ref.watch(localeProvider);
    final list = ["en", "hi"];

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Task 2",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          actions: [
            ToggleSwitch(
              initialLabelIndex:
                  ref.read(localeProvider.notifier).getLanguage() == "hi"
                      ? 1
                      : 0,
              totalSwitches: 2,
              labels: const ['En', 'Hi'],
              inactiveFgColor: Colors.white,
              onToggle: (index) {
                ref.read(localeProvider.notifier).toggle(list[index!]);
              },
            ),
          ],
        ),
        body: response.when(data: (data) {
          if (data != null) {
            final result = MyData.mapData(data);
            return ListView.builder(
                itemCount: result.length,
                itemBuilder: (BuildContext context, int index) {
                  var element = result[index];
                  return ExpansionTile(
                      title: CustomCard(
                        slug: element.getSlug(locale.languageCode),
                        date: element.createDate,
                        description: element.description,
                        isParent: true,
                      ),
                      children: element.children!.map((e) {
                        return CustomCard(
                            slug: e.getSlug(locale.languageCode),
                            isParent: false,
                            description: e.description,
                            date: e.createDate);
                      }).toList());
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }, error: (e, s) {
          return const Center(child: Text("Something went wrong"));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
