import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instacia = PreferenciasUsuario._interna();

  factory PreferenciasUsuario() {
    return _instacia;
  }

  PreferenciasUsuario._interna();

  late SharedPreferences _preferencias;

  initPrefencias() async {
    _preferencias = await SharedPreferences.getInstance();
  }

  String get getNombreUsuario {
    return _preferencias.getString('nombreUsuario') ?? '';
  }

  set setNombreUsuario(String valor) {
    _preferencias.setString('nombreUsuario', valor);
  }
}
