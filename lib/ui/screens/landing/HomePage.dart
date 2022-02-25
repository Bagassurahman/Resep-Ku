
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resep_masakan/models/recipe_model.dart';
import 'package:resep_masakan/resources/recipes_services.dart';
import 'package:resep_masakan/ui/common/button/button.dart';
import 'package:resep_masakan/ui/common/shimmer/shimmerList.dart';
import 'package:resep_masakan/ui/screens/landing/DetailRecipePage.dart';
import 'package:resep_masakan/utils/configs/const.dart';
import 'package:resep_masakan/utils/guidelines.dart';
import 'package:resep_masakan/utils/pageOrientations.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  RecipesServices recipesServices = RecipesServices();
  bool loading = true;
  List<Recipe> listRecipes=[];
  List<Recipe> listCategory=[];
  final TextEditingController _controllerSearch=TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllCategory();
    _getAllRecipes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageOrientation.orientationPortrait();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: _body()));
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Container(
          width: 180.0,
          child: new Text('Find the best recipe!',
            style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w700),
          ),
          margin: EdgeInsets.only(left: 10.0, top: 60.0, bottom: 10.0),
        ),
        _searchFieldForm(),
        _listCategory(),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 5.0)),
        _buildAllRecipes()
      ],
    );
  }

  Widget _buildAllRecipes() {
    return Expanded(
      flex: 10,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          child: RefreshIndicator(
            onRefresh: _refreshRecipes,
            child: loading
                ? Container(
              child: Center(child: ShimmerList()),
            )
                : _listRecipes(),
          ),
        ),
      ),
    );
  }

  Widget _searchFieldForm() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _searchField(),
    );
  }

  Widget _searchField() {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        _getRecipesBySearch(value);
        _controllerSearch.clear();
      },
      controller: _controllerSearch,
      autocorrect: false,
      style: TextStyle(fontSize: 14),

      decoration: new InputDecoration(
        focusColor: Color(PRIMARY_COLOR),
        hoverColor: Color(PRIMARY_COLOR),

        contentPadding:
        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        // filled: true,
        fillColor: Color(GREY_2),
        border: InputBorder.none,
        hintText: "Search for food here",
        hintStyle: TextStyle(fontStyle: FontStyle.italic),
        prefixIcon: Icon(
          Icons.search,
          color: Color(GREY),
        ),
      ),
    );
  }

  Widget _listCategory() {
    return listCategory.length > 0
        ? Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCategory.length,
            itemBuilder: (context, index) {
              final category = listCategory[index];
              return _buildItemCategory(category, index);
            }),
      ),
    )
        : Container();
  }

  Widget _listRecipes() {
    return listRecipes == null
        ? Center(
      child: Text(
        ERROR_LOAD_RECIPE,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    )
        : listRecipes.length < 1
        ? Center(
      child: Text(
        INFO_RECIPE_EMPTY,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    )
        : ListView.builder(
        shrinkWrap: true,
        itemCount: listRecipes.length,
        itemBuilder: (context, index) {
          final recipes = listRecipes[index];
          return Container(
              margin: EdgeInsets.only(
                  bottom: index == listRecipes.length ? 20.0 : 0.0),
              child: _buildItemRecipe(recipes, index));
        });
  }

  Widget _buildItemRecipe(Recipe recipe, int index) {
    return GestureDetector(
      onTap: () {
        navigateToDetail(recipe);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(children: <Widget>[
          _imageWidget(
            recipe.thumb??"",
          ),
          _imageOpacity(),
          _title(recipe.title??""),
          _keterangan(recipe)
        ]),
      ),
    );
  }

  Widget _buildItemCategory(Recipe recipe, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0)
          _getAllRecipes();
        else
          _getRecipesByCategory(recipe.key!);
      },
      child: Container(
          margin: EdgeInsets.only(
              left: 10.0, right: index == listCategory.length - 1 ? 10 : 0),
          child: OutlineRoundButton(
            buttonName: recipe.category ?? "-",
            buttonColor: Colors.white,
          )),
    );
  }

  void _getAllRecipes() async {
    _setLoading(true);
    recipesServices.getNewRecipes().then((data) {
      if (data == null) {
        setState(() {
          _setLoading(false);
          listRecipes = [];
        });
      } else if (data == []) {
        _setLoading(false);
        listRecipes = [];
      } else {
        setState(() {
          listRecipes = data;
          _setLoading(false);
        });
      }
    });
  }

  void _getAllCategory() async {
    recipesServices.getCategoryRecipes().then((data) {
      if (data == null) {
        setState(() {
          listCategory = [];
        });
      } else if (data == []) {
        listCategory = [];
      } else {
        setState(() {
          Recipe r = new Recipe();
          r.category = "Semua";
          listCategory = data;
          listCategory.insert(0, r);
        });
      }
    });
  }

  void _getRecipesByCategory(String category) async {
    if (listRecipes.length > 0) listRecipes.clear();
    _setLoading(true);
    recipesServices.getRecipesByCategory(category).then((data) {
      if (data == null) {
        setState(() {
          _setLoading(false);
          listRecipes = [];
        });
      } else if (data == []) {
        _setLoading(false);
        listRecipes = [];
      } else {
        setState(() {
          listRecipes = data;
          _setLoading(false);
        });
      }
    });
  }

  void _getRecipesBySearch(String query) async {
    if (listRecipes.length > 0) listRecipes.clear();
    _setLoading(true);
    recipesServices.getSearchRecipes(query).then((data) {
      if (data == null) {
        setState(() {
          _setLoading(false);
          listRecipes = [];
        });
      } else if (data == []) {
        _setLoading(false);
        listRecipes = [];
      } else {
        setState(() {
          listRecipes = data;
          _setLoading(false);
        });
      }
    });
  }

  Future<Null> _refreshRecipes() async {
    await Future.delayed(Duration(seconds: 1));
    _getAllCategory();
    _getAllRecipes();
  }

  _setLoading(bool status) {
    setState(() {
      loading = status;
    });
  }

  Widget _imageWidget(String url) {
    return CachedNetworkImage(
      height: 150,
      imageUrl: url != null ? url : imageDefault,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(GREY_COLOR_BACKGROUND),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Color(GREY_COLOR_BACKGROUND),
          image: DecorationImage(
            image: AssetImage('assets/placeholder.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }

  Widget _imageOpacity() {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.1),
                  Colors.black,
                ],
                stops: [
                  0.0,
                  1.0
                ])));
  }

  Widget _title(String title) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _keterangan(Recipe recipe) {
    return Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.accessibility_rounded,
                    color: Colors.white,
                  ),
                  Text(recipe.dificulty ?? "-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                  Container(
                    child: Icon(
                      Icons.repeat_one,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Text(recipe.portion ?? "-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                  Container(
                    child: Icon(
                      Icons.access_time_sharp,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Text(recipe.times ?? "-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
        ));
  }

  void navigateToDetail(Recipe recipe) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => DetailRecipePage(recipe: recipe),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
