import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resep_masakan/ui/screens/splash/splashPage.dart';

import 'utils/guidelines.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        title: 'Resep-Ku',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(PRIMARY_COLOR),
            primarySwatch: primary_swatch_color,
            fontFamily: 'Montserrat',
            primaryTextTheme:
                TextTheme(headline1: TextStyle(color: Colors.black))),
        home: SplashPage(),
      ),
    );
  }
}
