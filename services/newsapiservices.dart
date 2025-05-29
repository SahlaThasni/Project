import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/newsarticle.dart';

class NewsApiService {
  static const String _url = 'https://mocki.io/v1/3c3df97e-3aa5-4121-9ff0-648f1e5be17d';

  static Future<List<NewsArticle>> fetchNewsArticles() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final articles = jsonData['articles'] as List;
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news articles');
    }
  }
}
