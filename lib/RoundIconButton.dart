import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Widget icon;
  final Function f;
  RoundIconButton(this.icon, {@required this.f});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: icon,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
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
