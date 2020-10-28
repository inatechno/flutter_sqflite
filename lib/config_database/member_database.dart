import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MemberDatabase {
  static const EVENT_TABLE_NAME = "member";
  static final MemberDatabase _instance = MemberDatabase._internal();

  factory MemberDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  MemberDatabase._internal();

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "member.db");
    var theDatabase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDatabase;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE " +
        EVENT_TABLE_NAME +
        " ("
            "user_id STRING PRIMARY KEY, "
            "username TEXT, "
            "first_name TEXT, "
            "last_name TEXT, "
            "gender TEXT, "
            "password TEXT, "
            "status TEXT)");
  }

  Future closeDb() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
