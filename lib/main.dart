import 'package:fitness_magazine/model/article.dart';
import 'package:fitness_magazine/interface2/interface2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final List<Locale> appSupportedLocales = const [Locale('ar')];

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Magazines',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xFF364046),
        ),
      ),
      supportedLocales: appSupportedLocales,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ArticleCard extends StatelessWidget {
  final Article article;
  final String tagPrefix;

  const ArticleCard({
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
                    SecondInterface(article: article, TagPrefix: 'category'),
          ),
        );
      },
      child: Container(
        height: 155,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: 'category-${article.id}',
                child: Container(
                  height: double.infinity,

                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: article.image,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) =>
                              Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),

                decoration: BoxDecoration(
                  color: article.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: 'Somar',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      article.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
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
                        Icon(Icons.visibility_outlined, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'تغذية';
  final List<String> categories = ['تغذية', 'صحة', 'جمال', 'لياقة'];

  List<Article> get filteredArticles {
    List<Article> filteredList = [];

    for (var article in Article.articles) {
      if (article.category == selectedCategory) {
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
        appBar: AppBar(title: Text('مجلة صحية'), centerTitle: true),
        body: Column(
          children: [
            Container(
              height: 360,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Article.articles.length,
                itemBuilder: (context, index) {
                  final article = Article.articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SecondInterface(
                                article: article,
                                TagPrefix: 'all',
                              ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: 'all-${article.id}',
                              child: Container(
                                height: 210,
                                width: 300,
                                margin: EdgeInsets.only(left: 25),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: article.image,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
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
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(color: article.color),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 10,
                          ),
                          child: Center(
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
                        Text(
                          article.title,
                          style: TextStyle(
                            fontFamily: 'Somar',
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.only(top: 8),
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
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    selectedCategory = categories[index];
                  });
                },
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
            Expanded(
              child: TabBarView(
                children:
                    categories.map((category) {
                      final filtered = filteredArticles;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final article = filtered[index];
                            return ArticleCard(
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
