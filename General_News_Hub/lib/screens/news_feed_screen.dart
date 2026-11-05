import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_article.dart';
import '../providers/news_provider.dart';
import '../widgets/news_article_card.dart';
import 'article_detail_screen.dart';
import 'bookmarks_screen.dart';
import 'create_news_screen.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final _searchController = TextEditingController();
  String _category = 'All';
  static const _categories = ['All', 'National', 'World', 'Business', 'Politics', 'Entertainment'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();
    final query = _searchController.text.trim().toLowerCase();
    final List<NewsArticle> visible = provider.articles.where((article) {
      final matchesText = article.title.toLowerCase().contains(query) ||
          article.summary.toLowerCase().contains(query);
      final matchesCategory = _category == 'All' || article.category == _category;
      return matchesText && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('General News Hub'),
        actions: [
          IconButton(
            tooltip: 'Bookmarks',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookmarksScreen())),
            icon: const Icon(Icons.bookmarks_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateNewsScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Create post'),
      ),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
          children: [
            Text('Today’s headlines', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text('Browse stories by topic and save articles to read later.'),
            const SizedBox(height: 8),
            const Text('Starter stories are fictional demo content, not live news.', style: TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 14),
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search headlines...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) => ChoiceChip(
                  label: Text(_categories[index]),
                  selected: _category == _categories[index],
                  onSelected: (_) => setState(() => _category = _categories[index]),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (provider.isLoading)
              const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()))
            else if (provider.errorMessage != null)
              Center(child: Column(children: [
                Text(provider.errorMessage!),
                TextButton(onPressed: provider.load, child: const Text('Retry')),
              ]))
            else if (visible.isEmpty)
              const Padding(padding: EdgeInsets.all(24), child: Text('No articles found. Try another search or create a post.', textAlign: TextAlign.center))
            else ...[
              Text('${visible.length} articles', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              ...visible.map((article) => NewsArticleCard(
                    article: article,
                    isBookmarked: provider.isBookmarked(article.id),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article))),
                    onBookmarkTap: () => provider.toggleBookmark(article.id),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
