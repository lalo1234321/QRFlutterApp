import 'dart:io';

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';
export 'package:qrreaderapp/src/models/scan_model.dart';

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

  nuevoScanRaw(ScanModel nuevoScan) async{
    // se realiza únicamente una instancia de la base de datos, gracias al patrón singleton
    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO  Scans (id, tipo valor) "
      "VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')"
    );

    return res;


  }

  nuevoScan( ScanModel nuevoScan ) async{
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel> getScanId( int id ) async{
    final db = await database;

    final res = await db.query('Scans', where: ' id = ? ', whereArgs: [id] );

    // El resultado será entregado como un mapa, y debemos de entregar esta infromacion como si fuera un modelo del scanner

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map( (c) => ScanModel.fromJson(c) ).toList()
                              : [];

    return list;
  }

  // update

  Future<int> updateScan( ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.update('Scans', nuevoScan.toJson(), where: ' id = ? ', whereArgs: [nuevoScan.id]);

    // devuelve un 1 si lo hico y un 0 en caso contrario, la cantidad de registros realmente o cambios
    return res;
  }

  // eliminar registros

  Future<int> deleteScan(int id) async{
    final db = await database;

    final res = await db.delete('Scans', where: 'id = ? ', whereArgs: [id]);
    // devuelve la cantidad de registros en esa tabla
    return res;
  }


  Future<int> deleteAll() async {
    final db = await database;

    final res = await db.rawDelete(
      'DELETE FROM Scans'
    );

    return res;

  }


}