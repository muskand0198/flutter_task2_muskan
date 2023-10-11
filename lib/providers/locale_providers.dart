import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = Provider<Locale>((ref) {
  return PlatformDispatcher.instance.locale;
});
