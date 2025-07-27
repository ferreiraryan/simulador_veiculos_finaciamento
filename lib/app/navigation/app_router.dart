import 'package:flutter/material.dart';
import 'package:simulador_financeiro/features/financing/screens/detail_screen.dart';
import 'package:simulador_financeiro/features/financing/screens/home_screen.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String detailRoute = '/details';

  static Map<String, WidgetBuilder> get routes {
    return {
      homeRoute: (context) => const HomeScreen(),
      detailRoute: (context) => DetailScreen(),
    };
  }
}
