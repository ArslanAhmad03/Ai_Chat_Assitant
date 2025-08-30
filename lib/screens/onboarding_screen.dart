import 'package:ai_chat_assistant_mobile_app/constant/app_string.dart';
import 'package:ai_chat_assistant_mobile_app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:ai_chat_assistant_mobile_app/utils/screen_size.dart';
import 'package:ai_chat_assistant_mobile_app/utils/app_navigation.dart';
import 'package:ai_chat_assistant_mobile_app/screens/home_screen.dart';
import 'package:ai_chat_assistant_mobile_app/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void setStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(AppString.isFirst, true);
  }

  @override
  Widget build(BuildContext context) {
    final h = ScreenSize.height(context);
    final w = ScreenSize.width(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.05),

              /// title
              CustomText(
                text: "Your AI Assistant",
                style: TextStyle(
                  fontSize: w * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: h * 0.02),

              /// subtitle
              CustomText(
                text:
                    "Using this software, you can ask questions and receive articles using an intelligent assistant.",
                style: TextStyle(
                  fontSize: w * 0.045,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: h * 0.08),

              /// image
              Image.asset(
                'assets/images/onboard_image.png',
                width: w * 0.7,
                height: h * 0.35,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              /// botton
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: h * 0.04),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: h * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      createRoute(
                        widget: const HomeScreen(),
                        animationStyle: 'scaleBounce',
                      ),
                    );
                    // set
                    setStatus();
                  },
                  child: CustomText(
                    text: "Continue",
                    style: TextStyle(fontSize: w * 0.05, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
