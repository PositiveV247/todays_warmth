import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todays_warmth.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE missions (
            id TEXT PRIMARY KEY,
            date TEXT,
            completed INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertMission(String id, String date) async {
    final db = await database;
    await db.insert(
      'missions',
      {'id': id, 'date': date, 'completed': 1},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}