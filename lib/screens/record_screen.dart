import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("기록")),
      body: Center(
        child: Text("📊 이번 주 온기 기록", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}