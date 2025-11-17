import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final data = await DBHelper().getAllMissions();
    setState(() => records = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("온기 기록"),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: records.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sentiment_very_satisfied,
                      size: 80, color: Colors.grey[400]),
                  SizedBox(height: 20),
                  Text(
                    "아직 온기가 없어요\n미션을 완료해보세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: records.length,
              itemBuilder: (context, i) {
                final r = records[i];
                final date = DateTime.parse(r['date']).toLocal();
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple[400],
                      child: Text(
                        "${i + 1}",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      "미션 ${r['id']} 완료!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${date.year}년 ${date.month}월 ${date.day}일 ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                    ),
                    trailing: Icon(Icons.favorite, color: Colors.pink[300]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadRecords,
        child: Icon(Icons.refresh),
        tooltip: "새로고침",
      ),
    );
  }
}