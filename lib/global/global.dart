import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Global {
  static late InAppWebViewController inAppWebViewController;

  static List<Map<String, String>> websitesList = [
    {
      'name': 'Netflix',
      'url': 'https://www.netflix.com/in/',
      'image': 'assets/images/netflix.png'
    },
    {
      'name': 'Disney+ Hotstar',
      'url': 'https://www.hotstar.com/in',
      'image': 'assets/images/disneyplus-hotstar.png'
    },
    {
      'name': 'Amazon Prime',
      'url':
          'https://www.primevideo.com/hp/video/offers/nonprimehomepage/ref=dvm_pds_amz_in_as_s_g_146?_encoding=UTF8&dvah=nonprimehomepage',
      'image': 'assets/images/AmazonPrime.png'
    },
    {
      'name': 'Sony Liv',
      'url': 'https://www.sonyliv.com/',
      'image': 'assets/images/sonyliv.png'
    },
    {
      'name': 'Zee5',
      'url':
          'https://www.zee5.com/?utm_source=GoogleSearch&utm_medium=Mark_CPA&utm_campaign=Search_SVOD_ZEE5-Brand-ZEE5-Only-Ex-Performance&utm_term=zee5&utm_content=Brand-ZEE5-Only-Ex&gclid=Cj0KCQjwnbmaBhD-ARIsAGTPcfXrkrdCrqx2mBpm55b9AoWdSNdDjOCYDDZHBD5PEs6xrUL-7pEhZy4aAolKEALw_wcB&gclsrc=aw.ds',
      'image': 'assets/images/Zee-5.png'
    },
    {
      'name': 'Voot',
      'url': 'https://www.voot.com/',
      'image': 'assets/images/Voot.png'
    },
    {
      'name': 'ALTBalaji',
      'url': 'https://www.altbalaji.com/',
      'image': 'assets/images/Altbalaji.png'
    },
    {
      'name': 'BIGFlix',
      'url': 'https://www.bigflix.com/',
      'image': 'assets/images/BIGFlix.png'
    },
    {
      'name': 'Shemaroo',
      'url': 'https://www.shemaroome.com/',
      'image': 'assets/images/Shemaroo.png'
    },
    {
      'name': 'Discovery Plus',
      'url':
          'https://www.discoveryplus.in/?gclid=CjwKCAjwwL6aBhBlEiwADycBICaPhYwXjxSh_f4rQHJW9it0E7Vrmdd_ol6GmZHpjbazyCa0UY-7IRoC6jMQAvD_BwE',
      'image': 'assets/images/discovery_plus.png'
    },
    {
      'name': 'Jio Cinema',
      'url': 'https://www.jiocinema.com/',
      'image': 'assets/images/Jiocinema.png'
    },
    {
      'name': 'YouTube',
      'url': 'https://www.youtube.com/',
      'image': 'assets/images/youtube.png'
    },
  ];
}
