import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: AppColors.primaryColor,
      background: AppColors.backgroundColor,
      onBackground: AppColors.textColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Nunito',
        color: AppColors.textColor,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito',
        color: AppColors.greyColor,
        fontSize: 16,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Nunito',
        color: AppColors.textColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontFamily: 'Nunito'),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: AppColors.primaryColor,
      background: AppColors.darkBackgroundColor,
      onBackground: AppColors.darkTextColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Nunito',
        color: AppColors.darkTextColor,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito',
        color: Colors.grey[400],
        fontSize: 16,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Nunito',
        color: AppColors.darkTextColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontFamily: 'Nunito'),
      ),
    ),
  );
}
