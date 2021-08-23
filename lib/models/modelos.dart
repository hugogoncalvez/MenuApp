// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final menuModelo = menuModeloFromJson(jsonString);

import 'dart:convert';

MenuModelo menuModeloFromJson(String str) =>
    MenuModelo.fromJson(json.decode(str));

String menuModeloToJson(MenuModelo data) => json.encode(data.toJson());

class MenuModelo {
  MenuModelo({
    this.id,
    required this.codigo,
    required this.descripcion,
    required this.precio,
    this.imagen,
  });

  int? id;
  String codigo;
  String descripcion;
  double precio;
  String? imagen;

  factory MenuModelo.fromJson(Map<String, dynamic> json) => MenuModelo(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        precio: json["precio"].toDouble(),
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
      };
}

// To parse this JSON data, do
//
//     final usuariosModel = usuariosModelFromJson(jsonString);

UsuariosModelo usuariosModelFromJson(String str) =>
    UsuariosModelo.fromJson(json.decode(str));

String usuariosModelToJson(UsuariosModelo data) => json.encode(data.toJson());

class UsuariosModelo {
  UsuariosModelo({
    this.id,
    required this.usuario,
    required this.passWord,
  });

  int? id;
  String usuario;
  String passWord;

  factory UsuariosModelo.fromJson(Map<String, dynamic> json) => UsuariosModelo(
        id: json["id"],
        usuario: json["usuario"],
        passWord: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "password": passWord,
      };
}
