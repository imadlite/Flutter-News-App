import 'package:flutter/material.dart';
import 'package:news_app/components/app_error.dart';
import 'package:news_app/components/app_loading.dart';
import 'package:news_app/components/componentes.dart';
import 'package:news_app/components/user_list_row.dart';
import 'package:news_app/users_list/models/news_list_model.dart';
import 'package:news_app/users_list/models/users_list_model.dart';
import 'package:news_app/users_list/view_models/news_views_model.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  String cat;
  HomeScreen({Key? key, required this.cat}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> kats = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = context.read<NewsViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('News'),
        actions: [
          IconButton(
            onPressed: () async {
              newsViewModel.setCategory(newsViewModel.categories!);
              print(newsViewModel.categories);
              await newsViewModel.getNews();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kats.length,
                    itemBuilder: (context, index) {
                      ///business entertainment general health science sports technology
                      final kat = kats[index];
                      return InkWell(
                        onTap: () async {
                          newsViewModel.setCategory(kat.toLowerCase());
                          await newsViewModel.getNews();
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: 100,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Image.asset('img/$kat.jpg')),
                                SizedBox(
                                  height: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    kat,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Column(
                children: [
                  _ui(newsViewModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _ui(NewsViewModel newsViewModel) {
    if (newsViewModel.loading!) {
      return AppLoading();
    }
    if (newsViewModel.categories == null) {
      return Center(
        child: Text("Select Category.."),
      );
    }
    print(newsViewModel.loading);
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        NewsModel newsModel = newsViewModel.business[index];
        return buildArticleItem(newsModel, context);
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: newsViewModel.business.length,
    );
  }
}
