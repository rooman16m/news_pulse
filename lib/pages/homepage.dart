import 'package:flutter/material.dart';
import 'package:news_pulse/model/breakingnews.dart';
import 'package:news_pulse/model/drawer.dart';
import 'package:news_pulse/model/newscategory.dart';
import 'package:news_pulse/model/trending_new.dart';
import 'package:news_pulse/services/heading_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('NEWS'),
              SizedBox(
                width: 5,
              ),
              Text(
                'PULSE',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Categories',
                  style: CustomText.haeadline,
                ),
              ),
              NewsCategory(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breaking News',
                      style: CustomText.haeadline,
                    ),
                    Text('View all',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              BreakingNews(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending News',
                      style: CustomText.haeadline,
                    ),
                    Text('View all',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(child: TrendingNews()),
            ],
          ),
        ));
  }
}
