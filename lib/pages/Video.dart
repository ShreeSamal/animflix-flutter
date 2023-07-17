import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Video extends StatefulWidget {
  const Video({super.key});
  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  InAppWebViewController? webViewController;
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var src = arguments['src'];
    var initialUrl = 'https://hls-player-silk.vercel.app/?src=' + src;
    debugPrint(src.toString());
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: InAppWebView(
              onEnterFullscreen: (controller) => {setLandscape()},
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl))),
        ),
      ],
    ));
  }
}
