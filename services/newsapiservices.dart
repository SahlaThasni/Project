import 'dart:convert';

import 'package:news_app/models/newsarticle.dart';
import 'package:http/http.dart' as http;



class NewsApiService {
  static const String _apiKey = 'YOUR_API_KEY'; // Replace this
  static const String _url =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

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
