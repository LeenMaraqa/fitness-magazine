import 'package:fitness_magazine/model/article.dart';
import 'package:fitness_magazine/interface2/interface2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('مجلة صحية'), centerTitle: true),
      body: Column(
        children: [
          Container(
            height: 385,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(top: 15),
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
                        builder: (context) => SecondInterface(article: article),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 240,
                            width: 330,
                            margin: const EdgeInsets.only(left: 25),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(article.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 35,
                            child: Icon(Icons.favorite_border_outlined),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(color: article.color),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 10,
                        ),
                        child: Center(
                          child: Text(
                            article.category,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Somar',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
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
                        width: 330,
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          article.body,
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 17,
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
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final bool isSelected = category == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration:
                        isSelected
                            ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFF001F54),
                                  width: 3,
                                ),
                              ),
                            )
                            : null,
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected ? Color(0xFF001F54) : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (selectedCategory.isNotEmpty)
            Container(
              height: 300,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SecondInterface(article: article),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(article.image),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 140,
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: article.color,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Somar',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    article.body,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Somar',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.share, color: Colors.white),
                                      SizedBox(width: 15),
                                      Icon(
                                        Icons.favorite_outline,
                                        color: Colors.white,
                                      ),
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
