import 'dart:convert';
import 'package:kitchenowl/models/recipe.dart';
import 'package:kitchenowl/models/tag.dart';
import 'package:kitchenowl/services/api/api_service.dart';

extension TagApi on ApiService {
  Future<Tag> getTag(Tag tag) async {
    final res = await get('/tag/${tag.id}');
    if (res.statusCode != 200) return null;

    final body = jsonDecode(res.body);
    return Tag.fromJson(body);
  }

  Future<List<Recipe>> getTagRecipes(Tag tag) async {
    final res = await get('/tag/${tag.id}/recipes');
    if (res.statusCode != 200) return null;

    final body = List.from(jsonDecode(res.body));
    return body.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<List<Tag>> searchTags(String query) async {
    final res = await get('/tag/search?query=$query');
    if (res.statusCode != 200) return null;

    final body = List.from(jsonDecode(res.body));
    return body.map((e) => Tag.fromJson(e)).toList();
  }

  Future<bool> deleteTag(Tag tag) async {
    final res = await delete('/tag/${tag.id}');
    return res.statusCode == 200;
  }

  Future<bool> updateTag(Tag tag) async {
    final res = await post('/item/${tag.id}', tag.toJson());
    return res.statusCode == 200;
  }
}
