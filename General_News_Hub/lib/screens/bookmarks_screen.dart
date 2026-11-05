import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';
import '../widgets/news_article_card.dart';
import 'article_detail_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();
    final bookmarks = provider.bookmarks;
    return Scaffold(
      appBar: AppBar(title: const Text('Saved articles')),
      body: bookmarks.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Text('No saved articles yet. Tap the bookmark icon on a story to save it.', textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: bookmarks
                  .map((article) => NewsArticleCard(
                        article: article,
                        isBookmarked: true,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article))),
                        onBookmarkTap: () => provider.toggleBookmark(article.id),
                      ))
                  .toList(),
            ),
    );
  }
}
