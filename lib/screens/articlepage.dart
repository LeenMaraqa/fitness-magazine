import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_magazine/screens/homepage.dart';
import 'package:fitness_magazine/model/data.dart';

class SecondInterface extends StatelessWidget {
  final Article article;
  final String tagPrefix;

  const SecondInterface({
    super.key,
    required this.article,
    required this.tagPrefix,
  });

  List<Article> relatedArticles() {
    List<Article> relatedList = [];

    for (var a in Article.articles) {
      if (a.category == article.category && a.id != article.id) {
        relatedList.add(a);
      }
    }

    return relatedList.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    final relatedArt = relatedArticles();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Hero(
                  tag: '$tagPrefix-${article.id}',
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: article.image,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Center(
                            child: Image.asset(
                              'assets/assets/images/png/placeholder.png',
                            ),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        article.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Somar',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        article.body,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Somar',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    if (relatedArticles().isNotEmpty)
                      Text(
                        'مقالات ذات صلة ',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Somar',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: relatedArt.length,
                      itemBuilder: (context, index) {
                        final article = relatedArt[index];
                        return CategoryCard(
                          article: article,
                          tagPrefix: 'category',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
