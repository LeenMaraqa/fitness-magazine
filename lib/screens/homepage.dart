import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_magazine/model/data.dart';
import 'package:fitness_magazine/screens/articlepage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String selectedCategory = 'تغذية';
  static const List<String> categories = ['تغذية', 'صحة', 'جمال', 'لياقة'];

  List<Article> filteredArticles(String category) {
    List<Article> filteredList = [];

    for (var article in Article.articles) {
      if (article.category == category) {
        filteredList.add(article);
      }
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('مجلة صحية', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            //First Main Section
            //Display list of recent articles
            Container(
              height: 335,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Article.articles.length,
                itemBuilder: (context, index) {
                  final article = Article.articles[index];
                  return MainCard(article: article, tagPrefix: 'main');
                },
              ),
            ),
            //Tabbar Section
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 25),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text(categories[0], style: TextStyle(fontSize: 18)),
                  ),
                  Tab(
                    child: Text(categories[1], style: TextStyle(fontSize: 18)),
                  ),
                  Tab(
                    child: Text(categories[2], style: TextStyle(fontSize: 18)),
                  ),
                  Tab(
                    child: Text(categories[3], style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
            //Second Main Section
            //Display list of articles by category
            Expanded(
              child: TabBarView(
                children:
                    categories.map((category) {
                      final filtered = filteredArticles(category);
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final article = filtered[index];
                            return CategoryCard(
                              article: article,
                              tagPrefix: 'category',
                            );
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  final Article article;
  final String tagPrefix;
  const MainCard({super.key, required this.article, required this.tagPrefix});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    SecondInterface(article: article, tagPrefix: 'main'),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        width: 325,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'main-${article.id}',
                  child: Container(
                    height: 200,
                    width: 325,
                    margin: EdgeInsets.only(left: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
                ),
                Positioned(
                  top: 10,
                  left: 35,
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            ColoredBox(
              color: article.color,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                child: Text(
                  article.category,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Somar',
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontFamily: 'Somar',
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    article.body,
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 17.5,
                      fontFamily: 'somar',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Article article;
  final String tagPrefix;
  const CategoryCard({
    super.key,
    required this.article,
    required this.tagPrefix,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    SecondInterface(article: article, tagPrefix: 'category'),
          ),
        );
      },
      child: Container(
        height: 125,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: article.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder:
                      (context, url) => Center(
                        child: Image.asset(
                          'assets/assets/images/png/placeholder.png',
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Expanded(
                flex: 3,
                child: ColoredBox(
                  color: article.color,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Somar',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox(height: 5),
                        Text(
                          article.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Somar',
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.share, color: Colors.white),
                            SizedBox(width: 15),
                            Icon(Icons.favorite_outline, color: Colors.white),
                            SizedBox(width: 15),
                            Icon(
                              Icons.visibility_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
