import 'dart:convert';

RecipeDetailModel recipeDetailModelFromJson(String str) => RecipeDetailModel.fromJson(json.decode(str));

String recipeDetailModelToJson(RecipeDetailModel data) => json.encode(data.toJson());

class RecipeDetailModel {
  RecipeDetailModel({
    this.method,
    this.status,
    required this.detail,
  });

  String? method;
  bool? status;
  Detail detail;

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) => RecipeDetailModel(
    method: json["method"],
    status: json["status"],
    detail: Detail.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "method": method,
    "status": status,
    "results": detail.toJson(),
  };
}

class Detail {
  Detail({
    this.title,
    this.thumb,
    this.servings,
    this.times,
    this.dificulty,
    this.author,
    this.desc,
    this.needItem,
    this.ingredient,
    this.step,
  });

  String? title;
  String? thumb;
  String? servings;
  String? times;
  String? dificulty;
  Author? author;
  String? desc;
  List<NeedItem>? needItem;
  List<String>? ingredient;
  List<String>? step;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    title: json["title"],
    thumb: json["thumb"],
    servings: json["servings"],
    times: json["times"],
    dificulty: json["dificulty"],
    author: Author.fromJson(json["author"]),
    desc: json["desc"],
    needItem: List<NeedItem>.from(json["needItem"].map((x) => NeedItem.fromJson(x))),
    ingredient: List<String>.from(json["ingredient"].map((x) => x)),
    step: List<String>.from(json["step"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "thumb": thumb,
    "servings": servings,
    "times": times,
    "dificulty": dificulty,
    "author": author??author!.toJson(),
    "desc": desc,
    "needItem": needItem??List<dynamic>.from(needItem!.map((x) => x.toJson())),
    "ingredient": ingredient??List<dynamic>.from(ingredient!.map((x) => x)),
    "step": step??List<dynamic>.from(step!.map((x) => x)),
  };
}

class Author {
  Author({
    this.user,
    this.datePublished,
  });

  String? user;
  String? datePublished;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    user: json["user"],
    datePublished: json["datePublished"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "datePublished": datePublished,
  };
}

class NeedItem {
  NeedItem({
    this.itemName,
    this.thumbItem,
  });

  String? itemName;
  String? thumbItem;

  factory NeedItem.fromJson(Map<String, dynamic> json) => NeedItem(
    itemName: json["item_name"],
    thumbItem: json["thumb_item"],
  );

  Map<String, dynamic> toJson() => {
    "item_name": itemName,
    "thumb_item": thumbItem,
  };
}
