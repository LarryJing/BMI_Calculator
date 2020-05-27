import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Widget icon;
  final Function f;
  RoundIconButton(this.icon, {@required this.f});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return RawMaterialButton(
      child: icon,
      constraints: BoxConstraints.tightFor(
        width: screenHeight / 17,
        height: screenHeight / 17,
      ),
      shape: CircleBorder(),
      fillColor: Colors.grey[800],
      elevation: 5.0,
      onPressed: f,
      onLongPress: () {
        for (int i = 0; i < 10; i++) f();
      },
    );
  }
}
