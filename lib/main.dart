import 'package:flutter/material.dart';
import 'package:ott_platforms/webPage.dart';

import 'global/global.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Educational websites"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Global.websitesList.length,
        itemBuilder: (context, i) => Ink(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WebPage(
                    urlDetails: Global.websitesList[i],
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 75,
                    height: 50,
                    child: Image.asset(
                      "${Global.websitesList[i]['image']}",
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "${Global.websitesList[i]['name']}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
