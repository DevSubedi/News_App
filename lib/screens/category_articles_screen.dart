import 'package:flutter/material.dart';
import '../models/article.dart';
import '../widgets/article_card.dart';
import 'detail_screen.dart';

class CategoryArticlesScreen extends StatelessWidget {
  final String category;
  final List<Article> allArticles;

  const CategoryArticlesScreen({
    super.key,
    required this.category,
    required this.allArticles,
  });

  @override
  Widget build(BuildContext context) {
    // Filter articles by selected category
    final filteredArticles =
        allArticles
            .where(
              (article) =>
                  article.category.toLowerCase() == category.toLowerCase(),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text('$category Articles')),
      body:
          filteredArticles.isEmpty
              ? const Center(child: Text('No articles in this category.'))
              : ListView.builder(
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return ArticleCard(
                    article: article,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArticleDetailPage(article: article),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
