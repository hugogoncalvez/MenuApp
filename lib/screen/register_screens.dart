import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:menu/data/database.dart';
import 'package:menu/models/modelos.dart';
import 'package:menu/widget/card_container.dart';
import 'package:menu/widget/input_decorations.dart';
import 'package:menu/widget/auth_background.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Registro',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    _LoginForm(),
                  ],
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                child: Text(
                  'Ya tiene una cuenta?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.indigo.withOpacity(0.1),
                    ),
                    shape: MaterialStateProperty.all(StadiumBorder())),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //

    final db = new DataBase();
    final _usuarioController = new TextEditingController();
    final _passController = new TextEditingController();

    return Container(
      child: Form(
        //mantener referencia al key
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              // se estable en value todo lo que tenga el email y se lo pasa al provider
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email,
              ),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Ingrese una derección de correo válida';
              },
              controller: _usuarioController,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              // se estable en value todo lo que tenga el pass y se lo pasa al provider
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Contraseña', prefixIcon: Icons.lock),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe tener más de 6 caracteres';
              },
              controller: _passController,
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final nuevoUsu = UsuariosModelo(
                      usuario: _usuarioController.text,
                      passWord: _passController.text);
                  final respuesta =
                      await db.getUsuarioByUsuario(usuario: nuevoUsu.usuario);

                  if (respuesta.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('el usuario ya existe',
                            textAlign: TextAlign.center),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    FocusScope.of(context).requestFocus(new FocusNode());
                  } else {
                    db.nuevoUsuario(nuevoUsu);
                    Navigator.pushReplacementNamed(context, 'login');
                  }
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color.fromRGBO(73, 144, 171, 1),
              child: Container(
                child: Text(
                  'Crear Cuenta',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
