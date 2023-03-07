import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes/Screens/AllQuotesScreen/View/AllQuotesPage.dart';
import 'package:quotes/Screens/HomeScreen/View/HomePage.dart';
import 'package:quotes/Screens/QuetosViewScreen/View/QuotesViewPage.dart';
import 'package:quotes/Screens/QuotesAddScreen/View/QuotesAddPage.dart';
import 'package:quotes/Screens/SeeAllQuotesScreen/View/SeeAllQuotesPage.dart';
import 'package:quotes/Screens/TabBarScreen/View/TabBarPage.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => HomePage(),
            'Tab': (context) => TabBarPage(),
            'Add': (context) => QuotesAddPage(),
            'SeeAll': (context) => SeeAllQuotesPage(),
            'View': (context) => QuotesViewPage(),
            'AllQ': (context) => AllQuotesPage(),
          },
        );
      },
    ),
  );
}
