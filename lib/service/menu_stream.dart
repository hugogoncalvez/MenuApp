import 'package:flutter/material.dart';
import 'dart:async';

import 'package:menu/data/database.dart';
import 'package:menu/models/modelos.dart';

class MenuStream extends ChangeNotifier {
  //
  static StreamController<List<MenuModelo>> _streamController =
      StreamController.broadcast();
  //
  static close() {
    _streamController.close();
  }

  static Stream<List<MenuModelo>> get streamControllerDatos =>
      _streamController.stream;

  static void obtieneItemsMenu() async {
    final db = new DataBase();
    final lista = await db.getTodosLosDatos();
    _streamController.add(lista);
  }

  static void obtieneItemsMenuPorId(String codigo) async {
    final db = new DataBase();
    final lista = await db.getDatosByID(codigo);
    _streamController.add(lista);
  }

  static void borrarTodos() async {
    final db = new DataBase();
    await db.deleteAll();
    obtieneItemsMenu();
  }

  static void borrarItemMenuPorId(String codigo) async {
    final db = new DataBase();
    await db.deleteByID(codigo);
    obtieneItemsMenu();
  }
}
