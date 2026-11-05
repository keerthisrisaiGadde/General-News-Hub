import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_article.dart';
import '../providers/news_provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});
  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        actions: [
          IconButton(
            onPressed: () => provider.toggleBookmark(article.id),
            icon: Icon(provider.isBookmarked(article.id) ? Icons.bookmark : Icons.bookmark_border),
          ),
          if (article.isUserCreated)
            IconButton(
              tooltip: 'Delete post',
              onPressed: () async {
                await provider.removeCustomArticle(article.id);
                if (context.mounted) Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(colors: [Color(0xFFBFD7F5), Color(0xFF7FA8E8)]),
            ),
            child: const Icon(Icons.newspaper, size: 72, color: Color(0xFF173B70)),
          ),
          const SizedBox(height: 18),
          Text(article.category.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          Text(article.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('${article.author} • ${article.publishedAt}', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 18),
          Text(article.summary, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Text(article.body, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6)),
          if (article.isUserCreated)
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text('User-created local post', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
