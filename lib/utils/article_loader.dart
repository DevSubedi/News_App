import 'dart:convert';
import 'package:flutter/services.dart';

import "../models/article.dart";

class ArticleLoader {
  static Future<List<Article>> loadArticles() async {
    final String response = await rootBundle.loadString('assets/mock.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Article.fromJson(json)).toList();
  }

  static Future<List<String>> loadCategories() async {
    final articles = await loadArticles();
    final Set<String> categories = articles.map((a) => a.category).toSet();
    return categories.toList();
  }
}
