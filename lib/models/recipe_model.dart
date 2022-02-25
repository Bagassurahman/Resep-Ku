import 'dart:convert';

RecipeModel recipeModelFromJson(String str) => RecipeModel.fromJson(json.decode(str));

String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
  RecipeModel({
    this.method,
    this.status,
   required this.data,
  });

  String? method;
  bool? status;
  List<Recipe> data;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    method: json["method"],
    status: json["status"],
    data: List<Recipe>.from(json["results"].map((x) => Recipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "method": method,
    "status": status,
    "results": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Recipe {
  Recipe({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
    this.category,
    this.url
  });

  String? title;
  String? thumb;
  String? key;
  String? times;
  String? portion;
  String? dificulty;
  String? category;
  String? url;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    title: json["title"],
    thumb: json["thumb"],
    key: json["key"],
    times: json["times"],
    portion: json["portion"],
    dificulty: json["dificulty"],
    category: json["category"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "thumb": thumb,
    "key": key,
    "times": times,
    "portion": portion,
    "dificulty": dificulty,
    "category": category,
    "url": url,
  };
}
