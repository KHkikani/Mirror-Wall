import 'dart:io';

import 'package:browser_app/bookMarkPage.dart';
import 'package:browser_app/global/Global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        title: const Text("Browser App"),
        leading: (!isInitController)
            ? Container()
            : FutureBuilder(
                future: Global.inAppWebViewController.canGoBack(),
                builder: (context, snapshort) {
                  print(snapshort.data);
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const bookMarkPage(),
              ),
            ),
            icon: Icon(Icons.bookmark),
          ),
          (!isInitController)
              ? Container()
              : FutureBuilder(
                  future: Global.inAppWebViewController.canGoForward(),
                  builder: (context, snapshort) {
                    print(snapshort.data);
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
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                onChanged: (val) {
                  searchText = val;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (searchText != null && searchText!.trim() != "") {
                          await Global.inAppWebViewController.loadUrl(
                            urlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://www.google.com/search?q=${searchText!.trim()}"),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.search),
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                InAppWebView(
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                          useHybridComposition: true)),
                  initialUrlRequest: URLRequest(
                    url: Uri.parse("https://www.google.co.in/"),
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

                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Uri? uri = await Global.inAppWebViewController.getUrl();

          Global.bookMarkList.add(uri.toString());

          // print(await Global.inAppWebViewController.);
        },
        child: Icon(
          Icons.bookmark_add_outlined,
        ),
      ),
    );
  }
}
