import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/pages/view_breakingnews.dart';
import 'package:news_pulse/services/breakingnewas_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BreakingNews extends StatefulWidget {
  const BreakingNews({super.key});

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  int activeIndex = 0;
  List<BreakingSlider> sliderList = [];
  String? errorMessage;

  Future<List<BreakingSlider>> getBreaking() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=422eedc6dd76434fa5dd9d247fd7fdc0';
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body.toString());
    if (jsonResponse['status'] == 'ok') {
      jsonResponse['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['title'] != null) {
          sliderList.add(BreakingSlider.fromJson(element));
        }
      });
    }
    return sliderList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BreakingSlider>>(
        future: getBreaking(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            sliderList = snapshot.data!;
            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, int index, int realIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewBreakingFully(
                                    breakingnewsUrl: sliderList[index].url!)));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: sliderList[index].urlToImage!,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                child: Text(
                                  sliderList[index].title!,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: 5,
                  effect: WormEffect(
                    activeDotColor: Colors.blue,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
