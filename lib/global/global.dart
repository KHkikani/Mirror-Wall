import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Global {
  static late InAppWebViewController inAppWebViewController;

  static List<Map<String, String>> websitesList = [
    {'name': 'Wikipedia', 'url': 'https://www.wikipedia.org/'},
    {'name': 'W3Schools', 'url': 'https://www.w3schools.com/'},
    {'name': 'JavatPoint ', 'url': 'https://www.javatpoint.com/'},
    {'name': 'TutorialsPoint ', 'url': 'https://www.tutorialspoint.com/index.htm'},
    {'name': 'Geeksforgeeks', 'url': 'https://www.geeksforgeeks.org/'},
    {'name': 'Edureka', 'url': 'https://www.edureka.co/'},
    {'name': 'Stackoverflow', 'url': 'https://stackoverflow.com/'},
  ];
}
