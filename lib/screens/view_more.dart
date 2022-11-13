import 'dart:async';
import 'dart:io';

import 'package:employee_app/widgets/log_out.dart';
import 'package:employee_app/widgets/navigation_controls.dart';
import 'package:employee_app/widgets/web_view_stack.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewMore extends StatefulWidget {
  final String url;
  const ViewMore({Key? key, required this.url}) : super(key: key);

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  final controller = Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 70,
        title: Text(
          widget.url,
          style: const TextStyle(
            overflow: TextOverflow.fade,
            color: Colors.black,
          ),
        ),
        actions: const [LogOut()],
      ),
      body: WebViewStack(controller: controller, url: widget.url),
      persistentFooterButtons: [
        NavigationControls(controller: controller),
      ],
    );
  }
}
