import 'package:flutter/material.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/widgets/article_card.dart';
import '../models/article.dart';
import '../utils/article_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News & Articles')),
      body: FutureBuilder<List<Article>>(
        future: ArticleLoader.loadArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading...
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading articles'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No articles found'));
          }

          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(
                article: article,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailPage(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
