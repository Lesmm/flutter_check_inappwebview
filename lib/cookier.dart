import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Cookier {
  static Future<void> setCookie(String url, String key, String value) async {
    String domain = getDomainName(url);
    Uri uri = Uri.parse(url);
    await CookieManager.instance().setCookie(url: uri, domain: domain, name: key, value: value, isHttpOnly: false);
  }

  static String getDomainName(String url) {
    Uri uri = Uri.parse(url);
    String domain = uri.host;
    return domain.startsWith("www.") ? domain.substring(4) : domain;
  }
}
