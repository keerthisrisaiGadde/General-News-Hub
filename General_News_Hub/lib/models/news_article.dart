class NewsArticle {
  const NewsArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.body,
    required this.author,
    required this.publishedAt,
    this.isUserCreated = false,
  });

  final String id;
  final String title;
  final String category;
  final String summary;
  final String body;
  final String author;
  final String publishedAt;
  final bool isUserCreated;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'summary': summary,
        'body': body,
        'author': author,
        'publishedAt': publishedAt,
        'isUserCreated': isUserCreated,
      };

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
        id: json['id'] as String,
        title: json['title'] as String,
        category: json['category'] as String,
        summary: json['summary'] as String,
        body: json['body'] as String,
        author: json['author'] as String,
        publishedAt: json['publishedAt'] as String,
        isUserCreated: json['isUserCreated'] as bool? ?? false,
      );
}
