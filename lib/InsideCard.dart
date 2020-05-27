import 'package:flutter/material.dart';

class InsideCard extends StatelessWidget {
  final double iconSize;
  final double fontSize = 20.0;
  final IconData icon;
  final String text;
  final double sizedBoxHeight;
  InsideCard(this.icon, this.sizedBoxHeight, this.text, {this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: iconSize,
        ),
        SizedBox(
          height: sizedBoxHeight,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Color(0xff8d8e98),
          ),
        ),
      ],
    );
  }
}
