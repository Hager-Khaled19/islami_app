import 'package:flutter/material.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/splash/splash_screen.dart';
import '../ui/screens/sura_details/sura_details_screen.dart';

class AppRoutes {
  static const String splash = SplashScreen.routeName;
  static const String home = HomeScreen.routeName;
  static const String suraDetails = SuraDetailsScreen.routeName;

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    suraDetails: (context) => const SuraDetailsScreen(),
  };
}