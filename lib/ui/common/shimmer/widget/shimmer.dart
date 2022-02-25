import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget {
  static Widget slider(context) {
    return Column(
      children: <Widget>[
        Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[350]!,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    height: 150.0,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  Container(
                    height: 150.0,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ],
              ),
            )),
        shimmerForText(80.0, 10.0, true),
      ],
    );
  }

  static Widget videoTraler(context) {
    return Column(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            margin: EdgeInsets.only(bottom: 16.0),
            height: 230.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ],
    );
  }

  static Widget search(context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  static Widget rowCategoryCard() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 35,
                child: Row(
                  children: List.generate(5, (index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                      height: 30.0,
                      width: 135.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0)),
                    );
                  }),
                )),
            Container(
                height: 35,
                child: Row(
                  children: List.generate(5, (index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                      height: 35.0,
                      width: 135.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0)),
                    );
                  }),
                )),
          ],
        )
      ],
    );
  }

  static Widget cardCategory() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        height: 50.0,
        width: 135.0,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  static Widget rowLearning() {
    return Container(
      height: 225.0,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return card(index);
        },
      ),
    );
  }

  static Widget rowClass() {
    return Column(
      children: <Widget>[
        infoClass(),
        Container(
          height: 225.0,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return card(index);
            },
          ),
        ),
      ],
    );
  }

  static Widget card(int index) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        width: 190.0,
        height: 200,
        margin: EdgeInsets.only(right: 5.0, left: index == 0 ? 20.0 : 5.0),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  static Widget infoClass() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        height: 50.0,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  static Widget informationProfil() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10, top: 18),
          child: Row(children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Padding(
                  //     padding: const EdgeInsets.only(bottom: 5.0),
                  //     child: _shimmerForText(100.0)),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: Colors.grey[200],
                          size: 60.0,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: _shimmerForText(100.0))
                      ])
                ],
              ),
            ),
          ]),
        ));
  }

  static Widget _shimmerForText(width) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          height: 13.0,
          width: width,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  static Widget shimmerForText(double width, double height, bool border) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[350]!,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(border ? 5.0 : 0.0)),
        ),
      ),
    );
  }
}
