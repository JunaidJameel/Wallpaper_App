import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class BottomSheett extends StatefulWidget {
  final String imagesurl;
  const BottomSheett({super.key, required this.imagesurl});

  @override
  State<BottomSheett> createState() => _BottomSheettState();
}

class _BottomSheettState extends State<BottomSheett> {
  Future<void> setwallpaper() async {
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imagesurl);

      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
    } catch (e) {
      print('Got an Error on SetWallpaper Function');
    }
  }

  // lock Screen
  Future<void> setwallpaperLockScreen() async {
    try {
      int location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imagesurl);

      bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
    } catch (e) {
      print('Got an Error on SetWallpaper Function');
    }
  }

  Future<void> SaveImageToGallery() async {
    try {
      GallerySaver.saveImage(widget.imagesurl, albumName: 'WallPaper')
          .then((value) {
        Fluttertoast.showToast(
            msg: 'WallPaper Downloaded ', gravity: ToastGravity.CENTER);
      });
    } catch (e) {
      print('Image is not Download');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Container(
              height: 0.7.h,
              width: 15.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Text(
            'What would you like to do?',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17.2.sp),
          ),
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () {
              setwallpaper();
              Get.back();
              Fluttertoast.showToast(
                  msg: 'WallPaper Updated', gravity: ToastGravity.CENTER);
            },
            child: ListTile(
              leading: Icon(Icons.image),
              title: Text('Set Wallpaper to Home Screen'),
            ),
          ),
          InkWell(
            onTap: () {
              setwallpaperLockScreen();
              Get.back();
              Fluttertoast.showToast(
                  msg: 'WallPaper Updated', gravity: ToastGravity.CENTER);
            },
            child: ListTile(
              leading: Icon(Icons.screen_lock_landscape),
              title: Text('Set Wallpaper to Lock Screen'),
            ),
          ),
          InkWell(
            onTap: () {
              SaveImageToGallery();
              Get.back();

              Fluttertoast.showToast(
                  msg: 'WallPaper Downloading ...',
                  gravity: ToastGravity.CENTER);
            },
            child: ListTile(
              leading: Icon(Icons.download),
              title: Text('Download Wallpaper'),
            ),
          ),
        ],
      ),
    );
  }
}
