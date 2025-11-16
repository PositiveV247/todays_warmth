import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? todayMission;

  @override
  void initState() {
    super.initState();
    loadTodayMission();
  }

  Future<void> loadTodayMission() async {
    try {
      final String data = await rootBundle.loadString('assets/data/missions.json');
      final List missions = json.decode(data);
      final random = missions[DateTime.now().day % missions.length];
      setState(() => todayMission = random);
    } catch (e) {
      setState(() => todayMission = {"text": "미션 로드 실패: $e"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today’s Warmth")),
      body: Center(
        child: todayMission == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("오늘의 미션", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 16),
                  Text(todayMission!['text'], style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text("⏱ ${todayMission!['duration']}"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(todayMission!['praise'] ?? "완료!")),
                      );
                    },
                    child: Text("완료!"),
                  ),
                ],
              ),
      ),
    );
  }
}