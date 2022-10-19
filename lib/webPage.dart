import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'global/global.dart';

class WebPage extends StatefulWidget {
  WebPage({Key? key, required this.urlDetails}) : super(key: key);

  Map? urlDetails;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late PullToRefreshController pullToRefreshController;
  String? searchText;

  bool isInitController = false;
  bool isCancelButtonOn = false;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(onRefresh: () async {
      if (Platform.isAndroid) {
        await Global.inAppWebViewController.reload();
      }
      if (Platform.isIOS) {
        Uri? uri = await Global.inAppWebViewController.getUrl();
        await Global.inAppWebViewController
            .loadUrl(urlRequest: URLRequest(url: uri));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.urlDetails!['name']}"),
        leading: (!isInitController)
            ? Container()
            : FutureBuilder(
                future: Global.inAppWebViewController.canGoBack(),
                builder: (context, snapshort) {
                  bool data = snapshort.data ?? false;

                  return (data)
                      ? IconButton(
                          onPressed: () async {
                            await Global.inAppWebViewController.goBack();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                        )
                      : Container();
                }),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.home),
          ),
          (!isInitController)
              ? Container()
              : FutureBuilder(
                  future: Global.inAppWebViewController.canGoForward(),
                  builder: (context, snapshort) {
                    bool data = snapshort.data ?? false;

                    return (data)
                        ? IconButton(
                            onPressed: () async {
                              await Global.inAppWebViewController.goForward();
                            },
                            icon: const Icon(Icons.arrow_forward_ios_outlined),
                          )
                        : Container();
                  }),
          (!isCancelButtonOn)
              ? Container()
              :
          IconButton(
            onPressed: ()async {
              await Global.inAppWebViewController.stopLoading();
            },
            icon: Icon(Icons.cancel_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
                android:
                    AndroidInAppWebViewOptions(useHybridComposition: true)),
            initialUrlRequest: URLRequest(
              url: Uri.parse(widget.urlDetails!['url']),
            ),
            onWebViewCreated: (val) {
              setState(() {
                Global.inAppWebViewController = val;
                isInitController = true;
              });
            },
            onLoadStart: (val, uri) {

              setState(() {
                isCancelButtonOn = true;
              });
            },
            onLoadStop: (val, uri) {
              pullToRefreshController.endRefreshing();
              setState(() {
                isCancelButtonOn = false;
              });
            },
            pullToRefreshController: pullToRefreshController,
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController.endRefreshing();
              }
              setState(() {
                this.progress = progress / 100;
                // urlController.text = url;
              });
            },
          ),
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
        ],
      ),
    );
  }
}
