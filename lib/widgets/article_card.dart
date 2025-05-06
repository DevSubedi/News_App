import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
import '../services/bookmark_service.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarkStatus();
  }

  // void checkBookmarkStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final currentList = prefs.getStringList('Bookmarked Titles') ?? [];

  //   setState(() {
  //     isBookmarked = currentList.contains(widget.article.title);
  //   });
  // }
  void _loadBookmarkStatus() async {
    bool bookmarked = await BookmarkService.isBookmarked(widget.article.title);
    setState(() {
      isBookmarked = bookmarked;
    });
  }

  void handleBookmarkToggle() async {
    await BookmarkService().SwitchingBookmark(widget.article.title);

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  // void handleBookmarkToggle() async {
  //   await BookmarkService().SwitchingBookmark(widget.article.title);
  //   checkBookmarkStatus();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.article.image,
                placeholder:
                    (context, url) => Container(
                      height: 100,
                      width: 120,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      height: 100,
                      width: 120,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // Text & bookmark
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and bookmark
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.article.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked ? Colors.blue : Colors.grey,
                          ),
                          onPressed: handleBookmarkToggle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.article.snippet,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.article.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
