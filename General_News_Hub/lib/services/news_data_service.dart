import '../models/news_article.dart';

class NewsDataService {
  // Fictional demo headlines for app UI demonstration; not live/current news.
  static const List<NewsArticle> sampleArticles = [
    NewsArticle(
      id: 'demo_001',
      title: 'City launches a new public reading initiative',
      category: 'National',
      summary: 'A fictional demo report about expanding access to community libraries.',
      body: 'This sample article demonstrates how a full news story appears in the app. The fictional initiative describes extended library hours, community reading spaces, and book donation drives. Replace this demonstration content with verified reporting before presenting the app as a live news service.',
      author: 'News Hub Demo Desk',
      publishedAt: 'Demo story',
    ),
    NewsArticle(
      id: 'demo_002',
      title: 'Global research teams share ideas on clean energy',
      category: 'World',
      summary: 'A fictional example covering international collaboration on clean energy research.',
      body: 'This is demonstration content, not a report of a real event. It illustrates an international news article layout with a summary and a longer body. A production news app should display verified reporting with a source name, publication date, and a link to the original article.',
      author: 'News Hub Demo Desk',
      publishedAt: 'Demo story',
    ),
    NewsArticle(
      id: 'demo_003',
      title: 'Small businesses explore digital payment tools',
      category: 'Business',
      summary: 'A sample business story about digital tools used by local shops.',
      body: 'This fictional article is included to populate the business category during development. It can be replaced with a properly attributed article from a permitted news source or an authorised live API.',
      author: 'News Hub Demo Desk',
      publishedAt: 'Demo story',
    ),
    NewsArticle(
      id: 'demo_004',
      title: 'Public policy discussion focuses on urban transport',
      category: 'Politics',
      summary: 'A fictional example of a policy discussion and its possible impact on commuters.',
      body: 'This sample story demonstrates the politics category. It is not a statement about an actual government decision or current political event. Teams should use reliable sources and preserve attribution when adding real news.',
      author: 'News Hub Demo Desk',
      publishedAt: 'Demo story',
    ),
    NewsArticle(
      id: 'demo_005',
      title: 'Independent film festival announces student showcase',
      category: 'Entertainment',
      summary: 'A fictional entertainment headline about a showcase for emerging filmmakers.',
      body: 'This demonstration article shows how entertainment coverage can be displayed. Replace it with a verified article or a user-created post for a real project demonstration.',
      author: 'News Hub Demo Desk',
      publishedAt: 'Demo story',
    ),
    NewsArticle(
      id: 'demo_006',
      title: 'Community groups organise a neighbourhood clean-up',
      category: 'National',
      summary: 'A fictional community update about local volunteering and civic participation.',
      body: 'This sample article is fictional and exists only to demonstrate the feed and detail screens. It can be removed or replaced by the team with an article based on a verified source.',
      author: 'News Hub Demo Desk',
      publishedAt: 'Demo story',
    ),
  ];
}
