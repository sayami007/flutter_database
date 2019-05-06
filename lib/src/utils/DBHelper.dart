import 'dart:io';

import 'package:database_project/src/model/ContactData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _database;
  static DBHelper _dbHelper;

  String _DBName = "contact.db";
  String _tableName = "UserContact";
  String _col1 = "id";
  String _col2 = "name";

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '$_DBName';
    var contactDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return contactDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDb();
    }
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_tableName($_col1 INTEGER PRIMARY KEY AUTOINCREMENT, $_col2 TEXT)');
  }

  Future<int> insertContact(ContactData data) async {
    Database db = await this.database;
    var result = db.insert(_tableName, data.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllRecord() async {
    Database db = await this.database;
    var value = await db.query('$_tableName');
    return value;
  }
}
