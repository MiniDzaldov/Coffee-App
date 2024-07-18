import 'package:flutter/material.dart';

import '../const.dart';

class AboutScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'About',
          style: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
      ),
      body: Center(
        child: Text('We have a Great Coffee'),
      ),
    );
  }
}
