import 'package:flutter/material.dart';
import 'app_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot App',

      // -----------------------------------------------------
      // LIGHT THEME
      // -----------------------------------------------------
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Colors.grey,
          secondary: Colors.red,
        ),

        navigationRailTheme: NavigationRailThemeData(
          useIndicator: true,
          indicatorColor: Colors.red,
          indicatorShape: const CircleBorder(),

          selectedIconTheme: const IconThemeData(
            size: 40,
            color: Colors.white,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 40,
            color: Colors.black,
          ),

          selectedLabelTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          unselectedLabelTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),

      // -----------------------------------------------------
      // DARK THEME
      // -----------------------------------------------------
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.red,
        ),

        navigationRailTheme: NavigationRailThemeData(
          useIndicator: true,

          indicatorColor: Colors.red,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),

          selectedIconTheme: const IconThemeData(
            size: 40,
            color: Colors.black,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 40,
            color: Colors.white,
          ),

          selectedLabelTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          unselectedLabelTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),

      themeMode: ThemeMode.system,
      home: const AppLayout(),
    );
  }
}
