import 'package:http/http.dart';
import 'package:resep_masakan/models/recipe_detail_model.dart';
import 'package:resep_masakan/models/recipe_model.dart';
import 'package:resep_masakan/utils/network/endPointUrl.dart';
import 'package:resep_masakan/utils/network/network.dart';

class RecipesServices {
  Client client = Client();
  final network = Network();

  Future<List<Recipe>?> getNewRecipes() async {
    final response = await network.getRequest(BASE_URL_NEW_RECIPES);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = recipeModelFromJson(response.body);
      return body.data;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return [];
    }
  }

  Future<Detail?> getDetailRecipes(String key) async {
    final response = await network.getRequest(BASE_URL_DETAIL_RECIPES+key);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = recipeDetailModelFromJson(response.body);
      return body.detail;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return null;
    }
  }

  Future<List<Recipe>?> getCategoryRecipes() async {
    final response = await network.getRequest(BASE_URL_CATEGORY_RECIPES);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = recipeModelFromJson(response.body);
      return body.data;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return [];
    }
  }

  Future<List<Recipe>?> getRecipesByCategory(String category) async {
    final response = await network.getRequest(BASE_URL_RECIPES_BY_CATEGORY + category);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = recipeModelFromJson(response.body);
      return body.data;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return [];
    }
  }

  Future<List<Recipe>?> getSearchRecipes(String query) async {
    final response = await network.getRequest(BASE_URL_SEARCH_RECIPES + query);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = recipeModelFromJson(response.body);
      return body.data;
    } else if (response.statusCode == 500) {
      return null;
    } else {
      return [];
    }
  }
}
