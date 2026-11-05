import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:general_news_hub/models/news_article.dart';
import 'package:general_news_hub/providers/news_provider.dart';
import 'package:general_news_hub/screens/news_feed_screen.dart';
import 'package:general_news_hub/services/news_storage_service.dart';

class FakeNewsStorageService extends NewsStorageService {
  @override
  Future<List<NewsArticle>> loadCustomArticles() async => [];

  @override
  Future<Set<String>> loadBookmarkIds() async => {};
}

void main() {
  testWidgets('news feed displays sample demo headlines', (tester) async {
    final provider = NewsProvider(FakeNewsStorageService());
    await provider.load();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(home: NewsFeedScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('General News Hub'), findsOneWidget);
    expect(find.text('City launches a new public reading initiative'), findsOneWidget);
  });
}
