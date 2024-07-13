import 'package:flutter/material.dart';
import 'package:news_pulse/pages/view_category.dart';
import 'package:news_pulse/services/newscategory_data.dart';

class NewsCategory extends StatelessWidget {
  const NewsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // color: Colors.red
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewCategory(name: categories[index]['name'])));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        categories[index]['image'],
                        width: 120,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black26,
                      ),
                      child: Center(
                        child: Text(
                          categories[index]['name'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
