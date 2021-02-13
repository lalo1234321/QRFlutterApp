import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async {
    if( _database!=null ){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'Scans.db' );
    return await openDatabase(
      path,
      version: 1,
      onOpen:(db) {},
      onCreate: (Database db, int version) async{
        await db.execute(
          'CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
          ')'
        );
      }
    );
  }

  // esta forma es para insertar código sql en crudo
  // necesitamos pasar los datos a travez de nuestro modelo y mandar el modelo como parámetro
  


}