import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ruggerifrontend/home/home.dart';
import 'package:ruggerifrontend/login/auth_control.dart';
import 'package:ruggerifrontend/login/login.dart';
import 'package:ruggerifrontend/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthMiddleware authController = Get.put(AuthMiddleware());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => Home(),
            middlewares: [authController],
            transition: Transition.fadeIn),
        GetPage(
          name: '/login',
          page: () => Login(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initializeApp() async {
    // Simulate initialization tasks (e.g., fetching data, setting up services)
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    _initializeApp().then((_) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;
            const duration =
                Duration(seconds: 1); // Adjust the duration as needed

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            var fadeAnimation = animation.drive(
              Tween(begin: 0.0, end: 1.0).chain(
                CurveTween(curve: curve),
              ),
            );

            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
          transitionDuration:
              Duration(seconds: 1), // Adjust the duration as needed
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/LogoRuggeri.png', // Adjust the path to your image
              width: 100, // Set your desired width
              // Set your desired height
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text('Carregando...', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
