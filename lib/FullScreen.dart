import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'BottomSheet.dart';

class FullScreen extends StatefulWidget {
  final String imagesurl;
  FullScreen({super.key, required this.imagesurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                height: 85.h,
                width: 100.w,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      widget.imagesurl,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Get.bottomSheet(BottomSheett(
                  imagesurl: widget.imagesurl,
                ));
              },
              child: Container(
                height: 7.h,
                width: 35.w,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Set Wallpaper',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
