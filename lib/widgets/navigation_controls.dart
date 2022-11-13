import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final Completer<WebViewController> controller;

  const NavigationControls({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;

        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.arrow_back_ios),
              Icon(Icons.replay),
              Icon(Icons.arrow_forward_ios),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // back
            IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No back history item'),
                      duration: Duration(milliseconds: 600),
                    ),
                  );
                  return;
                }
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            // reload
            IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(Icons.replay),
            ),
            // forward
            IconButton(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No forward history item'),
                      duration: Duration(milliseconds: 600),
                    ),
                  );
                  return;
                }
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        );
      },
    );
  }
}
