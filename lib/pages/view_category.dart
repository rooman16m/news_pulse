// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/pages/viewarticle.dart';
import 'package:news_pulse/services/viewcategory_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ViewCategory extends StatefulWidget {
  String name;
  ViewCategory({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  List<NewsCategoryModel> categoryList = [];

  Future<List<NewsCategoryModel>> getCategories(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=422eedc6dd76434fa5dd9d247fd7fdc0';
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body.toString());
    if (jsonResponse['status'] == 'ok') {
      jsonResponse['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          categoryList.add(NewsCategoryModel.fromJson(element));
        }
      });
    }
    return categoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Container(
        child: FutureBuilder(
            future: getCategories(widget.name.toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewArticle(
                                    blogUrl: categoryList[index].url!)));
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
                                    imageUrl: categoryList[index].urlToImage!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 110,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      categoryList[index].title!,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          categoryList[index].description!,
                                          maxLines: 3,
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
