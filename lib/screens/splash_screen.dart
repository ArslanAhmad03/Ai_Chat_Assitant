import 'package:ai_chat_assistant_mobile_app/constant/app_string.dart';
import 'package:ai_chat_assistant_mobile_app/screens/home_screen.dart';
import 'package:ai_chat_assistant_mobile_app/screens/onboarding_screen.dart';
import 'package:ai_chat_assistant_mobile_app/utils/app_navigation.dart';
import 'package:ai_chat_assistant_mobile_app/utils/app_text.dart';
import 'package:ai_chat_assistant_mobile_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool? status = false;

  getStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    status = pref.getBool(AppString.isFirst);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOutBack)).animate(_controller);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeIn)).animate(_controller);

    _controller.forward();

    //
    getStatus().then((value) {
      if (status == true) {
        Future.delayed(const Duration(seconds: 3)).then((_) {
          Navigator.pushReplacement(
            context,
            createRoute(
              widget: const HomeScreen(),
              animationStyle: 'scaleBounce',
            ),
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 3)).then((_) {
          Navigator.pushReplacement(
            context,
            createRoute(
              widget: const OnboardingScreen(),
              animationStyle: 'chatBubble',
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = ScreenSize.width(context);
    final h = ScreenSize.height(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6200EE), Color(0xFF3700B3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  'assets/images/splash_image.png',
                  width: w * 0.35,
                  height: w * 0.35,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: h * 0.03),
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomText(
                text: "Your AI Chat Assistant",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: h * 0.1),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
