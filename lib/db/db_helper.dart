import 'dart:ffi';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "schedule";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'schedule.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, _version) {
          print("creating a new one");
          return db.execute(
              "CREATE TABLE $_tableName("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "title STRING, "
                  "note TEXT, "
                  "type STRING, "
                  "duration INTEGER, "
                  "date STRING, "
                  "startTime STRING, "
                  "endTime STRING, "
                  "remind INTEGER, "
                  "repeat STRING, "
                  "color INTEGER, "
                  "isCompleted INTEGER)"
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertTask(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }


  static Future<List<Map<String, dynamic>>> queryTask() async {
    print("query function called");
    List<Map<String, dynamic>> result = await _db!.query(_tableName);
    print("The result is: $result");
    print("The length is: ${result.length}");
    print("The future.value is ${Future.value(result)}");
    return result;
  }

  static Future<List<Map<String, dynamic>>> rawQueryTask() async {
    List<Map<String, dynamic>> result = await _db!.rawQuery(
        'SELECT * FROM $_tableName');
    return result;
  }


  static Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await _db!.query(_tableName);
    return List.generate(maps.length, (i) {
      return Task.fromJson(maps[i]);
    });
  }

  static Future<int?> deleteTask(Task? task) async {
    print("update function called");
    return await _db?.delete(_tableName,
      where: 'id = ?',
      whereArgs: [task?.id],);
  }

  static Future<void> resetDb() async {
    String _path = await getDatabasesPath() + 'schedule.db';
    await deleteDatabase(_path);
    _db = null;
    initDb();
  }

  Future<List<Task>> queryTasks() async {
    final List<Map<String, dynamic>> taskMaps = await DBHelper.queryTask();
    return taskMaps.map((map) => Task.fromJson(map)).toList();
  }

}

