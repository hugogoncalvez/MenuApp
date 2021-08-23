import 'package:flutter/material.dart';
import 'package:menu/preferencias/pref_usuario.dart';
import 'package:menu/screen/home_page.dart';
import 'package:menu/screen/login_screens.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final preferencias = PreferenciasUsuario();

  String usuarioLogeado = '';

  @override
  void initState() {
    usuarioLogeado = preferencias.getNombreUsuario;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (usuarioLogeado.length > 0) {
      return HomePage();
    }
    return LoginScreen();
  }
}
