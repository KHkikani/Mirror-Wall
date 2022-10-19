import 'package:browser_app/global/Global.dart';
import 'package:browser_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class bookMarkPage extends StatefulWidget {
  const bookMarkPage({Key? key}) : super(key: key);

  @override
  State<bookMarkPage> createState() => _bookMarkPageState();
}

class _bookMarkPageState extends State<bookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BookMark"),),
      body: Column(
        children: Global.bookMarkList.map((e) => ListTile(
          style: ListTileStyle.drawer,
          onTap: ()async{

            await Global.inAppWebViewController.loadUrl(
              urlRequest: URLRequest(
                url: Uri.parse(
                    e),),);

            Navigator.of(context).pop();

          },
          title: Text(e),
        )).toList(),
      ),
    );
  }
}
