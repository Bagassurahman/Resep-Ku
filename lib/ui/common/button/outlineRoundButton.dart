import 'package:flutter/material.dart';
import 'package:resep_masakan/utils/guidelines.dart';

class OutlineRoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final TextStyle? buttonTextStyle;
  final String? buttonName;
  final Color? buttonColor;

  OutlineRoundButton({
    this.buttonName,
    this.onPressed,
    this.buttonColor,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.0,
      child: new Material(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(
            color: Color(MAIN),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: new Text(
                buttonName??"",
                // textDirection: TextDirection.ltr,
                style: buttonTextStyle != null
                    ? buttonTextStyle
                    : TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
