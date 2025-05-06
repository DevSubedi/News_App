import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
import '../widgets/article_card.dart';

class BookmarkScreen extends StatefulWidget {
  final List<Article> allArticles;
  const BookmarkScreen({super.key, required this.allArticles});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Article> bookmarkedArticles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadBookmarkArticles();
  }

  Future<void> loadBookmarkArticles() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedTitles =
        prefs.getStringList('Bookmarked Titles') ?? [];

    List<Article> matchedArticles =
        widget.allArticles.where((article) {
          return bookmarkedTitles.contains(article.title);
        }).toList();
    setState(() {
      bookmarkedArticles = matchedArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarked Articles')),
      body:
          bookmarkedArticles.isEmpty
              ? const Center(child: Text('No Bookmarks Yet'))
              : ListView.builder(
                itemCount: bookmarkedArticles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(
                    article: bookmarkedArticles[index],
                    onTap: () {},
                  );
                },
              ),
    );
  }
}
