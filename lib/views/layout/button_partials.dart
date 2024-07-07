import 'package:flutter/material.dart';

class ButtonPartials extends StatelessWidget {
  ButtonPartials({Key? key, this.text, this.onTap, this.colorButton})
      : super(key: key);

  String? text;
  VoidCallback? onTap;
  Color? colorButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0, // soften the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                6.0, // Move to bottom 5 Vertically
              ),
            ),
          ],
          color: colorButton,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$text',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Color(0xfffEFF0F1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
