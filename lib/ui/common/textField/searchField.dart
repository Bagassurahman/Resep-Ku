import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resep_masakan/utils/guidelines.dart';

class SearchField extends StatelessWidget {
  final String? hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final VoidCallback? onSubmit;
  final FocusNode _searchFocus = FocusNode();

  SearchField({this.hintText, this.onTap, this.controller, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _dismissKeyboard(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              height: 35.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(
                      width: 1.0, color: Color(BUTTON_ROUND_COLOR_GREY)),
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextFormField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  if (onSubmit != null) onSubmit!();
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Color(GREY_COLOR_TEXT_2)),
                  hintText: hintText,
                  prefixIcon: GestureDetector(
                    child: Icon(
                      Icons.search,
                      color: Color(GREY_COLOR_ICON),
                      size: 20,
                    ),
                    onTap: onTap,
                  ),
                  prefixStyle: TextStyle(fontSize: 12.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ));
  }

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
