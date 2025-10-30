import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:whats_app/providers/auth_provider.dart';
import 'package:whats_app/screens/splash/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/chat_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/phone_verification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'WhatsApp Clone',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeProvider.themeMode,
            home: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                // Show splash screen while loading
                if (authProvider.isLoading) {
                  return const SplashScreen();
                }

                // Show home screen if user is authenticated
                if (authProvider.user != null) {
                  // Initialize chats when user is logged in
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Provider.of<ChatProvider>(
                      context,
                      listen: false,
                    ).initializeChats();
                  });
                  return const HomeScreen();
                }

                // Show phone verification screen if not authenticated
                return const PhoneVerificationScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
