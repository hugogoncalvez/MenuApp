import 'package:flutter/material.dart';

import 'package:menu/models/modelos.dart';
import 'package:menu/preferencias/pref_usuario.dart';
import 'package:menu/service/menu_stream.dart';

import 'package:menu/widget/obtiene_imagen.dart';

class HomePage extends StatelessWidget {
  final preferencias = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    MenuStream.obtieneItemsMenu(); // cargo la lista de platos
    final Color colorPrincipal = Color.fromRGBO(73, 144, 171, 1);
    return Scaffold(
      appBar: AppBar(
        title: Text('Platos del Menú'),
        backgroundColor: colorPrincipal,
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: colorPrincipal,
            ),
            onPressed: (() {
              preferencias.setNombreUsuario = '';
              Navigator.pushNamedAndRemoveUntil(
                  context, 'inicio', (route) => false);
            }),
            icon: Icon(Icons.logout),
            label: Container(
              width: 50,
              child: Text('Cerrar Sesión'),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: MenuStream.streamControllerDatos,
        builder: (BuildContext contex, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Container();

          final List<MenuModelo> lista = snapshot.data;

          return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                    onTap: () {
                      final bool update = true;
                      String? imagenPath = '';
                      if (lista[index].imagen != null) {
                        imagenPath = lista[index].imagen;
                      }
                      Navigator.pushNamed(context, 'nuevoItem', arguments: {
                        'codigo': lista[index].codigo,
                        'descripcion': lista[index].descripcion,
                        'precio': lista[index].precio,
                        'imagen': imagenPath,
                        'modificando': update
                      });
                    },
                    child: _Dismissible(lista: lista, index: index));
              });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: colorPrincipal,
        child: Row(
          children: [
            Container(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(31, 107, 38, 1),
        onPressed: () {
          final bool update = false;
          Navigator.pushNamed(context, 'nuevoItem', arguments: {
            'codigo': '',
            'descripcion': '',
            'precio': '',
            'modificando': update
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _Dismissible extends StatelessWidget {
  const _Dismissible({
    Key? key,
    required this.lista,
    required this.index,
  }) : super(key: key);

  final List<MenuModelo> lista;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirma"),
              content: Text("Está seguro que desea eliminar el plato?"),
              actions: <Widget>[
                TextBut(textoBut: 'ELIMINAR'),
                TextBut(textoBut: 'CANCELAR'),
              ],
            );
          },
        );
      },
      background: containerBorrar(Alignment.centerLeft),
      secondaryBackground: containerBorrar(Alignment.centerRight),
      key: UniqueKey(),
      onDismissed: (direction) {
        MenuStream.borrarItemMenuPorId(lista[index].codigo);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  leading: obtieneImagen(lista[index].imagen),
                  title: Text(
                    lista[index].descripcion,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
                  ),
                  subtitle: Text(lista[index].codigo),
                ),
              ),
              LimitedBox(
                maxWidth: 115,
                child: ListTile(
                  title: Text(
                    '\$ ${lista[index].precio}',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container containerBorrar(AlignmentGeometry pos) {
    AlignmentGeometry posicion = pos;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: posicion,
      color: Colors.black45,
      child: Image(
        width: 60,
        height: 60,
        image: AssetImage('assets/delete.gif'),
      ), //Icon(Icons.delete_forever),
    );
  }
}

class TextBut extends StatelessWidget {
  const TextBut({
    required this.textoBut,
  });
  final textoBut;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(textoBut));
  }
}
