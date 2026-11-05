import 'package:flutter/foundation.dart';

import '../models/news_article.dart';
import '../services/news_data_service.dart';
import '../services/news_storage_service.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider(this._storage);

  final NewsStorageService _storage;
  final List<NewsArticle> _customArticles = [];
  Set<String> _bookmarkIds = {};
  bool isLoading = true;
  String? errorMessage;

  List<NewsArticle> get articles => [..._customArticles, ...NewsDataService.sampleArticles];
  List<NewsArticle> get bookmarks =>
      articles.where((article) => _bookmarkIds.contains(article.id)).toList();
  bool isBookmarked(String id) => _bookmarkIds.contains(id);

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      _customArticles
        ..clear()
        ..addAll(await _storage.loadCustomArticles());
      _bookmarkIds = await _storage.loadBookmarkIds();
    } catch (_) {
      errorMessage = 'Could not load saved news. Please retry.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(String id) async {
    if (_bookmarkIds.contains(id)) {
      _bookmarkIds.remove(id);
    } else {
      _bookmarkIds.add(id);
    }
    notifyListeners();
    await _storage.saveBookmarkIds(_bookmarkIds);
  }

  Future<void> addArticle(NewsArticle article) async {
    _customArticles.insert(0, article);
    notifyListeners();
    await _storage.saveCustomArticles(_customArticles);
  }

  Future<void> removeCustomArticle(String id) async {
    _customArticles.removeWhere((article) => article.id == id);
    _bookmarkIds.remove(id);
    notifyListeners();
    await _storage.saveCustomArticles(_customArticles);
    await _storage.saveBookmarkIds(_bookmarkIds);
  }
}
