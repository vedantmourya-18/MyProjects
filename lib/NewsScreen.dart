import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsScreen extends StatefulWidget {

  final String webUrl;
  NewsScreen({this.webUrl});
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  final Completer<WebViewController> completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF525252),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text('News',
            style: GoogleFonts.cinzelDecorative(
              textStyle: TextStyle(
                fontSize: 30,
                color: Color(0xFF525252),
                decoration: TextDecoration.none,
              ),
            )),
      ),
      body: Container(
        height: _size.height,
         width: _size.width,
         child: WebView(
           initialUrl: widget.webUrl,
           onWebViewCreated: ((WebViewController webViewController){
             completer.complete(webViewController);
           }),
         ),
      ),
    );
  }
}
