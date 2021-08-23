import 'package:menu/models/modelos.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DataBase {
  //
  static Database? _database; // instancia de la Base de Datos

//instancia de la clase personalizada, singletone con costructor privado _()
  static final DataBase db = DataBase._();

  DataBase._();

  factory DataBase() {
    return db;
  }

  Future<Database> get database async {
    //
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // path de donde esta la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'DBmenu.db');

    //  crear tablas
    String tabla1 =
        'CREATE TABLE platos (id INTEGER PRIMARY KEY, codigo TEXT, descripcion TEXT, precio REAL, imagen TEXT)';
    String tabla2 =
        'CREATE TABLE usuarios (id INTEGER PRIMARY KEY, usuario TEXT, password TEXT)';
    List<String> query = [tabla1, tabla2];

    //
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      for (String item in query) {
        await db.execute(item);
      }
    });
  }

  // Usuarios

  Future<int> nuevoUsuario(UsuariosModelo nuevoItem) async {
    final db = await database;
    int res = 0;
    //
    res = await db.insert(
      'usuarios',
      nuevoItem.toJson(),
    );
    return res;
  }

  Future<int> deleteUsu() async {
    final db = await database;

    final res = await db.delete('usuarios');

    return res;
  }

  Future<List<UsuariosModelo>> getUsuario(
      {required String usuario, required String password}) async {
    List<UsuariosModelo> listaUsuarios = [];

    try {
      final db = await database;
      final res = await db.query('usuarios',
          where: 'usuario = ? and password = ?',
          whereArgs: [usuario, password]);
      listaUsuarios = (res.isNotEmpty)
          ? res.map((item) => UsuariosModelo.fromJson(item)).toList()
          : [];
    } catch (e) {
      print(e.toString());
    } finally {}
    return listaUsuarios;
  }

  Future<List<UsuariosModelo>> getUsuarioByUsuario(
      {required String usuario}) async {
    List<UsuariosModelo> listaUsuarios = [];

    try {
      final db = await database;
      final res = await db
          .query('usuarios', where: 'usuario = ?', whereArgs: [usuario]);
      listaUsuarios = (res.isNotEmpty)
          ? res.map((item) => UsuariosModelo.fromJson(item)).toList()
          : [];
    } catch (e) {
      print(e.toString());
    } finally {}
    return listaUsuarios;
  }

  //  Items del Menu

  Future<int> nuevoDato(MenuModelo nuevoItem) async {
    final db = await database;
    //
    final int res = await db.insert(
      'platos',
      nuevoItem.toJson(),
    );
//  res es el ID del ultimo resgistro insertado !!!
    return res;
  }

  Future<int> update(MenuModelo nuevoItem) async {
    final db = await database;

    final String sql =
        'Update platos set codigo = "${nuevoItem.codigo}", descripcion = "${nuevoItem.descripcion}", precio = ${nuevoItem.precio}, imagen = "${nuevoItem.imagen}" where codigo = "${nuevoItem.codigo}"';
    final res = await db.rawUpdate(sql);

    return res;
  }

  Future<List<MenuModelo>> getDatosByID(String codigo) async {
    final db = await database;
    //
    final res =
        await db.query('platos', where: 'codigo = ?', whereArgs: [codigo]);

    return res.isNotEmpty
        ? res.map((s) => MenuModelo.fromJson(s)).toList()
        : [];
  }

  Future<List<MenuModelo>> getTodosLosDatos() async {
    final db = await database;
    //
    final res = await db.query('platos', orderBy: 'Descripcion');

    return res.isNotEmpty
        ? res.map((s) => MenuModelo.fromJson(s)).toList()
        : [];
  }

  Future<int> deleteByID(String codigo) async {
    final db = await database;

    final res =
        await db.delete('platos', where: 'codigo = ?', whereArgs: [codigo]);

    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;

    final res = await db.rawDelete('''
    DELETE FROM platos
    ''');

    return res;
  }
}
