import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullScreen extends StatefulWidget {
  final String url;

  const FullScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FullScreen")),
      body: Column(
        children: [
          Expanded(
              child: Image.network(
            widget.url,
            fit: BoxFit.cover,
          )),
          ElevatedButton(
              onPressed: () {
                setWallpaper();
              },
              child: Text("Set Wallpaper"))
        ],
      ),
    );
  }

  void setWallpaper() async {
    File singleFile = await DefaultCacheManager().getSingleFile(widget.url);
    // await AsyncWallpaper.setWallpaperFromFile(
    //   filePath: singleFile.path,
    //   goToHome: false,
    //   wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
    // );

    await AsyncWallpaper.setWallpaper(
      url: widget.url,
      goToHome: false,
      wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
    );
    print("AsyncWallpaper Done");
  }
}
