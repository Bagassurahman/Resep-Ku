import 'package:flutter/material.dart';
import 'package:resep_masakan/ui/common/listStyle.dart';
import 'package:resep_masakan/utils/guidelines.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatefulWidget {
  @override
  _ShimmerListState createState() => _ShimmerListState();
}

class _ShimmerListState extends State<ShimmerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: body());
  }

  body() {
    return ScrollConfiguration(
      behavior: ListStyle(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _content(),
            _content(),
            _content(),
            _content(),
            _content(),
            _content(),
            _content(),
            _content(),
          ],
        ),
      ),
    );
  }

  _content() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: Color(GREY_COLOR_BACKGROUND),
          borderRadius: BorderRadius.circular(3.0)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[300]!,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title(),
                  address(),
                ],
              ),
              choices()
            ]),
      ),
    );
  }

  title() {
    return Container(
      height: 20.0,
      width: 150.0,
      margin: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(3.0)),
    );
  }

  address() {
    return Container(
      height: 10.0,
      width: 100.0,
      margin: EdgeInsets.only(left: 10.0, top: 5.0),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(3.0)),
    );
  }

  choices() {
    return Container(
      height: 20.0,
      width: 50.0,
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
