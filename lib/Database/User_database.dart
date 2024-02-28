import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {

  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'userDb');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "userDb");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets/database', 'userDb'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }

    return false;
  }

  Future<List<Map<String, dynamic>>> getDetails() async {
      Database db = await initDatabase();
    List<Map<String, dynamic>> list = await db.rawQuery("select * from User");
    print(list);
    return list;
  }

  Future<int> insertUser(Map<String, dynamic> map) async {
    Database db = await initDatabase();
    int insert = await db.insert("User", map);
    return insert;
  }

  Future<void> deleteUser(id) async {
    Database db = await initDatabase();
    var res = db.delete("User", where: "id = ?", whereArgs: [id]);
  }

  Future<int> editUser(Map<String, Object?> map, id) async {
    Database db = await initDatabase();

    var res = await db.update("User", map, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
