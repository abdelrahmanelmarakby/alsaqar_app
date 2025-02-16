import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:alsagr_app/firebase_options.dart';
import 'package:alsagr_app/others/error_screen.dart';
import 'package:alsagr_app/pages/homepage.dart';

import 'core/language/translations_service.dart';
import 'others/no_internet_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _backViewOn = true;
  final botToastBuilder = BotToastInit();

  @override
  void initState() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (!await InternetConnectionChecker().hasConnection) {
        if (!_backViewOn) {
          setState(() {
            _backViewOn = true;
          });
          Get.dialog(const NoInternetDialog(canDismiss: true));
        }
      } else {
        if (_backViewOn) {
          Get.back();
          setState(() {
            _backViewOn = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      title: "نادي الصقر",
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      fallbackLocale: TranslationsService.fallbackLocale,
      supportedLocales: TranslationsService.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translations: TranslationsService(),
      defaultTransition: Transition.fadeIn,
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        child = botToastBuilder(context, child!);
        return ResponsiveBreakpoints.builder(
          child: child,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
      home: const HomePage(
        title: 'نادي الصقر',
        imagePath: '',
      ),
    );
  }
}
