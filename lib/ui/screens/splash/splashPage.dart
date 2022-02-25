import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:resep_masakan/ui/screens/landing/HomePage.dart';
import 'package:resep_masakan/utils/configs/const.dart';
import 'package:resep_masakan/utils/guidelines.dart';
import 'package:resep_masakan/utils/pageOrientations.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // cekToken();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    PageOrientation.orientationPortrait();
    return Scaffold(
      backgroundColor: Color(MAIN),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                  tag: 'logo-resepku',
                  child: new Image(
                      image: AssetImage('assets/logo_resepku.png'),
                      height: 65,
                      width: 65,
                      fit: BoxFit.cover)),
            ),
            Text(
              APP_NAME,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
            // Container(
            //   child: new Image.asset(
            //     'assets/splash.png',
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void navigateToHome() {
    _timer = new Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: HomePage()),
      );
    });
  }

  // void navigateToNoInternetPage() {
  //   Route route = MaterialPageRoute(builder: (context) => PageNoInternet());
  //   Navigator.of(context).pushReplacement(route);
  // }

  // void navigateToLanding() {
  //   Timer(const Duration(seconds: 2), () {
  //     Route route = FadePageRoute(widget: MenuNavigationPage());
  //     Navigator.of(context).pushReplacement(route);
  //   });
  // }
}
