import 'package:flutter/material.dart';

import 'package:menu/preferencias/pref_usuario.dart';
import 'package:menu/screen/home_page.dart';
import 'package:menu/screen/inicio_App.dart';
import 'package:menu/screen/login_screens.dart';
import 'package:menu/screen/nuevo_item.dart';
import 'package:menu/screen/register_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencias = PreferenciasUsuario();
  await preferencias.initPrefencias();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'inicio',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomePage(),
        'register': (_) => RegisterScreen(),
        'nuevoItem': (_) => NuevoItemPage(),
        'inicio': (_) => InicioPage()
      },
    );
  }
}
