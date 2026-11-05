import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/news_article.dart';

class NewsStorageService {
  static const _customArticlesKey = 'custom_news_articles';
  static const _bookmarksKey = 'bookmarked_news_ids';

  Future<List<NewsArticle>> loadCustomArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_customArticlesKey);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => NewsArticle.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  Future<void> saveCustomArticles(List<NewsArticle> articles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _customArticlesKey,
      jsonEncode(articles.map((article) => article.toJson()).toList()),
    );
  }

  Future<Set<String>> loadBookmarkIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_bookmarksKey) ?? []).toSet();
  }

  Future<void> saveBookmarkIds(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarksKey, ids.toList());
  }
}
