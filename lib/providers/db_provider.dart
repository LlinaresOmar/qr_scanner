import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  //Constructor privado
  static final DBProvider db = DBProvider._();
  DBProvider._();

  static Database? _database;

   Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ScanDB.db");

    print("Database path: $path");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans (
                  id INTEGER PRIMARY KEY,
                  tipo TEXT,
                  valor TEXT
                )
              ''');
      },
    );
  }
  
}