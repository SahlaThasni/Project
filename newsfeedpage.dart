import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/newsarticle.dart';
import 'package:news_app/newsviewpage.dart';
import 'package:news_app/services/newsapiservices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  late Future<List<NewsArticle>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = NewsApiService.fetchNewsArticles();
  }

  String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('d MMMM, yyyy').format(date); // 16 April, 2025
  }

  Future<void> saveBookmark(NewsArticle article) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.add(jsonEncode(article.toJson()));
    await prefs.setStringList('bookmarks', bookmarks);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Bookmarked successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Feed")),
      body: FutureBuilder<List<NewsArticle>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: article.urlToImage != null
                        ? Image.network(article.urlToImage!, width: 100, fit: BoxFit.cover)
                        : null,
                    title: Text(article.title ?? 'No Title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(article.description ?? 'No Description'),
                        const SizedBox(height: 5),
                        Text(
                          '${article.sourceName} • ${formatDate(article.publishedAt!)}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () => saveBookmark(article),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsWebViewPage(url: article.url!),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
