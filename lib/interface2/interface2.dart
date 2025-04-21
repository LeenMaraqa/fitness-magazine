import 'package:fitness_magazine/main.dart';
import 'package:flutter/material.dart';
import 'package:fitness_magazine/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SecondInterface extends StatelessWidget {
  final Article article;
  final String TagPrefix;

  const SecondInterface({
    super.key,
    required this.article,
    required this.TagPrefix,
  });

  List<Article> get relatedArticles {
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Hero(
                  tag: '$TagPrefix-${article.id}',
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(article.image),
                        fit: BoxFit.cover,
                      ),
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
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
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
                    if (relatedArticles.isNotEmpty)
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
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: relatedArticles.length,
                      itemBuilder: (context, index) {
                        final article = relatedArticles[index];
                        return ArticleCard(
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
