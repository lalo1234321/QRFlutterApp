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
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 40)),
            Text('QR app')
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: () {})
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () {
          print("Hola mundo");
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
      );
  }

      Widget  _crearBottomNavigationBar() {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
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