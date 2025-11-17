import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todays_warmth.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE completed_missions (
            id TEXT PRIMARY KEY,
            date TEXT
          )
        ''');
      },
    );
  }

  // 미션 완료 저장
  Future<void> saveMission(String missionId) async {
    final db = await database;
    await db.insert(
      'completed_missions',
      {
        'id': missionId,
        'date': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 저장된 미션 불러오기
  Future<List<Map<String, dynamic>>> getAllMissions() async {
    final db = await database;
    return await db.query('completed_missions', orderBy: 'date DESC');
  }
}