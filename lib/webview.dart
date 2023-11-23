import 'package:flutter/material.dart';
import 'package:flutter_check_inappwebview/cookier.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {

  final String url;

  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebView')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
            verticalScrollbarPosition: AndroidVerticalScrollbarPosition.SCROLLBAR_POSITION_RIGHT,
          ),
          crossPlatform: InAppWebViewOptions(
            supportZoom: false,
            useOnLoadResource: true,
            useShouldOverrideUrlLoading: true,
          ),
        ),
        onTitleChanged: (InAppWebViewController controller, String? title) {
          print("【WebView】onTitleChanged: $title");
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          print("【WebView】onProgressChanged: $progress");
        },
        onLoadResource: (InAppWebViewController controller, LoadedResource resource) {
          print("【WebView】onLoadResource: $resource");
        },
        onLoadStart: (InAppWebViewController controller, Uri? url) {
          print("【WebView】onLoadStart: $url");
        },
        onLoadStop: (InAppWebViewController controller, Uri? url) {
          print("【WebView】onLoadStop: $url");
        },
        onLoadError: (InAppWebViewController controller, Uri? url, int code, String message) {
          print("【WebView】onLoadError: $url, $code, $message");
        },
        onLoadHttpError: (InAppWebViewController controller, Uri? url, int statusCode, String description) {
          print("【WebView】onLoadHttpError: $url, $statusCode, $description");
        },
        onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
          print("【WebView】onConsoleMessage: $consoleMessage");
        },
        onWebViewCreated: (InAppWebViewController controller) {
          print("【WebView】onWebViewCreated");
          ()async{
            await Future.delayed(const Duration(milliseconds: 5000));
            await Cookier.setCookie(widget.url, "NowTime", "now is ${DateTime.now()}");
            print("【WebView】cookie set success");
          }();
        },
        shouldOverrideUrlLoading: (InAppWebViewController controller, NavigationAction navigationAction) async {
          print("【WebView】shouldOverrideUrlLoading: $navigationAction");
          await Cookier.setCookie(widget.url, "Morning", "I love you");
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
