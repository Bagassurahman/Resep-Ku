import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:resep_masakan/models/recipe_detail_model.dart';
import 'package:resep_masakan/models/recipe_model.dart';
import 'package:resep_masakan/resources/recipes_services.dart';
import 'package:resep_masakan/utils/guidelines.dart';

class DetailRecipePage extends StatefulWidget {
  final Recipe recipe;

  DetailRecipePage({required this.recipe});

  @override
  DetailRecipePageState createState() => new DetailRecipePageState();
}

class DetailRecipePageState extends State<DetailRecipePage> {
  RecipesServices recipeServices = RecipesServices();
  bool loading = true;
  Detail? recipeDetail;

  @override
  void initState() {
    super.initState();
    _getDetailRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(MAIN),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              height: 200,
              imageUrl: widget.recipe.thumb ?? imageDefault,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Color(GREY_COLOR_BACKGROUND),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  color: Color(GREY_COLOR_BACKGROUND),
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
            ),
            Container(
              margin: EdgeInsets.only(top: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: loading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Loading...",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
                            ),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ))
                  : _body(),
            ),
            Positioned(
              child: AppBar(
                title: Container(),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipeDetail!.title ?? "-",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
          (recipeDetail!.author==null?"-":recipeDetail!.author!.user ?? "-") +
              " - " +
              (recipeDetail!.author==null?"-":recipeDetail!.author!.datePublished ?? "-"),
          style: TextStyle(fontSize: 14.0, color: Colors.black),
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _item(Icons.accessibility_rounded,
                  widget.recipe.dificulty ?? "-", false),
              _item(Icons.repeat_one, widget.recipe.portion ?? "-", true),
              _item(
                  Icons.access_time_sharp, widget.recipe.times ?? "-", false),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: Text(recipeDetail!.desc ?? "-",
                style: TextStyle(fontSize: 14.0, color: Colors.black))),
        Container(
          margin: EdgeInsets.only(top: 25.0, bottom: 10.0),
          child: Text(
            "Bahan-bahan:",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        _ListToString(recipeDetail!.ingredient??[], true),
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            "Langkah:",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        _ListToString(recipeDetail!.step??[], false),
      ],
    );
  }

  Widget _item(IconData icon, String text, bool center) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: center ? 10 : 0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Color(MAIN),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Icon(icon),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ListToString(List list, bool withMinis) {
    var value = StringBuffer();
    list.forEach((item) {
      if (withMinis) value.write("- ");
      value.write(item);
      value.write(" \n");
    });
    return Text(
      value.toString(),
      style: TextStyle(fontSize: 14.0),
    );
  }

  void _getDetailRecipe() async {
    _setLoading(true);
    recipeServices.getDetailRecipes(widget.recipe.key!).then((data) {
      if (data == null) {
        setState(() {
          _setLoading(false);
          recipeDetail = null;
        });
      } else {
        setState(() {
          recipeDetail = data;
          _setLoading(false);
        });
      }
    });
  }

  _setLoading(bool status) {
    setState(() {
      loading = status;
    });
  }
}
