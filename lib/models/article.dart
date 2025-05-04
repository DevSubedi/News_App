// article.dart
class Article {
  final int id;
  final String title;
  final String snippet;
  final String content;
  final String image;
  final String category;

  Article({
    required this.id,
    required this.title,
    required this.snippet,
    required this.content,
    required this.image,
    required this.category,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      snippet: json['snippet'],
      content: json['content'],
      image: json['image'],
      category: json['category'],
    );
  }
}
