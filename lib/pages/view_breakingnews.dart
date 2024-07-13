// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewBreakingFully extends StatefulWidget {
  String breakingnewsUrl;
  ViewBreakingFully({
    Key? key,
    required this.breakingnewsUrl,
  }) : super(key: key);

  @override
  State<ViewBreakingFully> createState() => _ViewBreakingFullyState();
}

class _ViewBreakingFullyState extends State<ViewBreakingFully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NEWS'),
            SizedBox(
              width: 5,
            ),
            Text(
              'PULSE',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.breakingnewsUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
