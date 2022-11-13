import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  final String url;
  final Completer<WebViewController> controller;

  const WebViewStack({
    Key? key,
    required this.controller,
    required this.url,
  }) : super(key: key);

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var _loading = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
          onPageStarted: (url) {
            setState(() {
              _loading = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              _loading = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _loading = 100;
            });
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
        if (_loading < 100)
          LinearProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.white,
            minHeight: 5,
            value: _loading / 100.0,
          ),
      ],
    );
  }
}
