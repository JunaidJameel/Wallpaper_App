import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart ' as http;
import 'package:wallpaper/FullScreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _HomeState();
}

class _HomeState extends State<Wallpaper> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001e1ddd92e4ccc4c7c8ba25e98235577c4'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images);
    });
  }

  Loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001e1ddd92e4ccc4c7c8ba25e98235577c4'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Do you want to Exit?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            FullScreen(
                                imagesurl: images[index]['src']['large2x']),
                          );
                        },
                        child: Container(
                          color: Color.fromARGB(255, 221, 185, 185),
                          child: Image.network(
                            images[index]['src']['large'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            InkWell(
              onTap: () {
                Loadmore();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Load More',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
