import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AppTheme {
  // Duration for theme transitions
  static const Duration transitionDuration = Duration(milliseconds: 300);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: WhatsAppColors.tealGreen,
      scaffoldBackgroundColor: WhatsAppColors.lightBackground,

      // Smooth transitions between themes
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      colorScheme: const ColorScheme.light(
        primary: WhatsAppColors.tealGreen,
        secondary: WhatsAppColors.lightGreen,
        surface: WhatsAppColors.lightBackground,
        error: WhatsAppColors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: WhatsAppColors.lightTextPrimary,
        onError: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: WhatsAppColors.lightAppBarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      ),

      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xB3FFFFFF),
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 12),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: WhatsAppColors.lightGreen,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      cardTheme: CardThemeData(
        color: WhatsAppColors.lightBackground,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),

      dividerTheme: const DividerThemeData(
        color: WhatsAppColors.lightDivider,
        thickness: 1,
        space: 0,
      ),

      iconTheme: const IconThemeData(
        color: WhatsAppColors.lightIconColor,
        size: 24,
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minLeadingWidth: 40,
        horizontalTitleGap: 12,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: WhatsAppColors.lightTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: WhatsAppColors.lightBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: WhatsAppColors.lightTextSecondary,
          fontSize: 15,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: WhatsAppColors.darkCardBackground,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        elevation: 8,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: const TextStyle(
          color: WhatsAppColors.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: WhatsAppColors.tealGreen,
      scaffoldBackgroundColor: WhatsAppColors.darkBackground,

      // Smooth transitions between themes
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      colorScheme: const ColorScheme.dark(
        primary: WhatsAppColors.tealGreen,
        secondary: WhatsAppColors.lightGreen,
        surface: WhatsAppColors.darkCardBackground,
        error: WhatsAppColors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: WhatsAppColors.darkTextPrimary,
        onError: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: WhatsAppColors.darkAppBarBackground,
        foregroundColor: WhatsAppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        iconTheme: IconThemeData(
          color: WhatsAppColors.darkTextPrimary,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: WhatsAppColors.darkTextPrimary,
          size: 24,
        ),
      ),

      tabBarTheme: const TabBarThemeData(
        labelColor: WhatsAppColors.tealGreen,
        unselectedLabelColor: WhatsAppColors.darkTextSecondary,
        indicatorColor: WhatsAppColors.tealGreen,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 12),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: WhatsAppColors.lightGreen,
        foregroundColor: Colors.black,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      cardTheme: CardThemeData(
        color: WhatsAppColors.darkCardBackground,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),

      dividerTheme: const DividerThemeData(
        color: WhatsAppColors.darkDivider,
        thickness: 1,
        space: 0,
      ),

      iconTheme: const IconThemeData(
        color: WhatsAppColors.darkIconColor,
        size: 24,
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minLeadingWidth: 40,
        horizontalTitleGap: 12,
        textColor: WhatsAppColors.darkTextPrimary,
        iconColor: WhatsAppColors.darkIconColor,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: WhatsAppColors.darkTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: WhatsAppColors.darkCardBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: WhatsAppColors.darkTextSecondary,
          fontSize: 15,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: WhatsAppColors.darkCardBackground,
        contentTextStyle: const TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: WhatsAppColors.darkCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        elevation: 8,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: WhatsAppColors.darkCardBackground,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: const TextStyle(
          color: WhatsAppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
