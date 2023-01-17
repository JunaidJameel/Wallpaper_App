import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wallpaper/Wallpaper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void finish() {
    Get.off(Wallpaper());
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), finish);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration( 
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 225, 69, 252),
              Color.fromARGB(255, 249, 249, 122)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 28.h,
            ),
            Image.asset(
              'images/splash.png',
              height: 35.h,
            ),
            Text(
              'Choose your Wallpapers ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
