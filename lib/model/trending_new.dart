import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/pages/viewarticle.dart';
import 'package:news_pulse/services/trending_newsdata.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TrendingNews extends StatefulWidget {
  const TrendingNews({super.key});

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  List<TrendingArticle> newsArticles = [];

  Future<List<TrendingArticle>> getArticles() async {
    String url =
        'https://newsapi.org/v2/everything?q=apple&from=2024-07-07&to=2024-07-07&sortBy=popularity&apiKey=422eedc6dd76434fa5dd9d247fd7fdc0';
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body.toString());
    if (jsonResponse['status'] == 'ok') {
      jsonResponse['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          newsArticles.add(TrendingArticle.fromJson(element));
        }
      });
    }
    return newsArticles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewArticle(
                                  blogUrl: newsArticles[index].url!)));
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: newsArticles[index].urlToImage!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 110,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    newsArticles[index].title!,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        newsArticles[index].description!,
                                        maxLines: 3,
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
