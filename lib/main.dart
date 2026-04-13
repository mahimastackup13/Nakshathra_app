import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nakshatra_app/screens/home_screen.dart';
import 'package:nakshatra_app/screens/splash_screen.dart';
import 'package:nakshatra_app/screens/login_screen.dart';
import 'package:nakshatra_app/screens/cart_screen.dart';
import 'package:nakshatra_app/provider/cart_provider.dart';
import 'package:nakshatra_app/screens/profile_screen.dart';
import 'package:nakshatra_app/screens/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const NakshathraApp(),
    ),
  );
}

class NakshathraApp extends StatelessWidget {
  const NakshathraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nakshathra Jewellery',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),

      },
    );
  }
}
