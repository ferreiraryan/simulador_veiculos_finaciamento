import 'package:flutter/material.dart';
import 'package:simulador_financeiro/app/navigation/app_router.dart';
import 'package:simulador_financeiro/shared/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Financiamento',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.homeRoute,
      routes: AppRouter.routes,
    );
  }
}
