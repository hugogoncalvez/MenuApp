import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  //
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderrIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _HeaderrIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    //
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.4,
          //decoration: _purpleBackground(),
          child: Image(
            image: AssetImage('assets/comidas.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(124, 191, 210, 1),
              Color.fromRGBO(37, 104, 134, 1)
            ], begin: Alignment.topCenter),
          ),
        )),
      ],
    );
  }
}
