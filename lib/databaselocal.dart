import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:random_joker_app/joker.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseLocal {
  DataBaseLocal._();

  static final DataBaseLocal db = DataBaseLocal._();
  static Database _base;

  Future<Database> get base async {
    if (_base != null) return _base;
    _base = await init();
    return _base;
  }

  init() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/base.db';
    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: createDB);
  }

  createDB(Database base, int version) async{
    await base.execute('CREATE TABLE JOKER (ID INTEGER PRIMARY KEY, VALUE TEXT)');
  }

  //CRUD
  insert(String joker) async{
    final db = await base;
    var res = db.insert('JOKER', {'value' : joker});
    return res;
  }

  selectOne(int id) async{
    final db = await base;
    var res = await db.query('JOKER', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Joker.fromJsonSimple(res.first) : Null;
  }

  Future<List<Joker>> getAllJokers() async{
    final db = await base;
    var res = await db.query('JOKER');
    List<Joker> list = res.isNotEmpty ? res.map((e) => Joker.fromJsonSimple(e)).toList() : [];
    return list;
  }

  delete(int id) async{
    final db = await base;
    db.delete('JOKER', where: 'ID = ?', whereArgs: [id]);
  }

  deleteAll() async {
    final db = await base;
    db.rawDelete("Delete * from JOKER");
  }

}
