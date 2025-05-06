import 'package:flutter/material.dart';
import 'package:news_app/screens/bookmark_screen.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/screens/category_articles_screen.dart';
import 'package:news_app/widgets/article_card.dart';
import '../models/article.dart';
import '../utils/article_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = ArticleLoader.loadArticles();
  }

  Future<void> _refreshOnReturn() async {
    setState(() {
      futureArticles = ArticleLoader.loadArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: futureArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('News & Articles')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('News & Articles')),
            body: Center(child: Text('Error loading articles')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text('News & Articles')),
            body: Center(child: Text('No articles found')),
          );
        }

        final articles = snapshot.data!;
        final uniqueCategories =
            articles
                .map((a) => a.category)
                .toSet()
                .toList(); // extract unique categories

        return Scaffold(
          appBar: AppBar(
            title: Text('News & Articles'),
            actions: [
              IconButton(
                icon: Icon(Icons.bookmarks_rounded),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BookmarkScreen(allArticles: articles),
                    ),
                  );
                  _refreshOnReturn();
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('All'),
                  onTap: () {
                    Navigator.pop(context); // close drawer
                  },
                ),
                ...uniqueCategories.map((category) {
                  return ListTile(
                    title: Text(category),
                    onTap: () {
                      Navigator.pop(context); // close drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CategoryArticlesScreen(
                                category: category,
                                allArticles: articles,
                              ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          body: ListView.builder(
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
          ),
        );
      },
    );
  }
}
