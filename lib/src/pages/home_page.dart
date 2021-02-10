import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

// para poder cambiar los valores de un bottomnaviagationBar se necesita usar un statefull widget
// y esto es porque los valores seŕan modificados en tiempo de ejecución
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(0),
      bottomNavigationBar: _crearBottomNavigationBar(),
          );
        }

      Widget  _crearBottomNavigationBar() {
        return BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {},
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapas'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mark_chat_read),
              label: 'Direcciones'
            ),
          ],
        );
      }

  Widget _callPage(int paginaActual) {
    switch( paginaActual ) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}