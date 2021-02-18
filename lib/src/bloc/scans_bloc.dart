
import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new  ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener scans de la base de datos
    obtenerScans();

  }

  // broadcast porque este stream estará siendo escuchado por varios archivos 
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;


  // cuando trabajamos con streams debemos de cerrar el flujo de datos
  // signo de interrogación para validar que si hay algo en el scanController se haga algo y si no, no se hace nada}

  dispose() {
    _scansController?.close();
  }


  obtenerScans() async{
    _scansController.sink.add( await DBProvider.db.getScans());
  }
}