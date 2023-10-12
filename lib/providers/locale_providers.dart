import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class MyLocale extends StateNotifier<Locale> {
  MyLocale(this.pref) : super(Locale(pref?.getString("language") ?? "en"));

  final SharedPreferences? pref;

  void toggle(String lang) {
    state = (lang == "hi") ? const Locale("hi") : const Locale("en");
    pref!.setString("language", lang);
  }

  String getLanguage(){
    return pref!.getString("language") ?? "en";
  }
}

final localeProvider = StateNotifierProvider<MyLocale, Locale>((ref) {
  final pref = ref.watch(sharedPrefs);
  return MyLocale(pref);
});
