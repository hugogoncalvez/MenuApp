import 'package:flutter/material.dart';
import 'dart:io';

obtieneImagen(String? imagen) {
  if (imagen == null || imagen.length == 0) {
    return Image(
      fit: BoxFit.cover,
      image: AssetImage('assets/no-image.png'),
    );
  }
  return Hero(
    tag: '$imagen',
    child: Image.file(
      File(imagen),
      fit: BoxFit.fill,
      width: 65,
      height: 65,
    ),
  );
}
