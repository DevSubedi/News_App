import 'dart:convert';
import 'package:flutter/services.dart';

import "../models/article.dart";

class ArticleLoader {
  static Future<List<Article>> loadArticles() async {
    final String response = await rootBundle.loadString('assets/mock.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Article.fromJson(json)).toList();
  }
}
