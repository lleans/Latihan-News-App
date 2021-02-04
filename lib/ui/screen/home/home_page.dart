import 'package:flutter/material.dart';
import 'package:NewsAppLatihanEzyIndustries/ui/widget/search/search_widget.dart';
import 'package:NewsAppLatihanEzyIndustries/model/news_response.dart';
import 'package:NewsAppLatihanEzyIndustries/ui/widget/itemnews/item_news_widget.dart';
import 'package:NewsAppLatihanEzyIndustries/server/repository/news_repository.dart';
import 'package:NewsAppLatihanEzyIndustries/server/api_exception_mapper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsRepository _newsRepository = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SearchWidget(),
        builListView(),
      ],
    );
  }

  Widget builListView() => Expanded(
        child: FutureBuilder<NewsResponse>(
          future: _newsRepository.getAllNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                  ApiExceptionMapper.toErrorMessage(snapshot.error).toString());
            } else {
              return ListView(
                  children: snapshot.data.articles.map(
                (news) {
                  return ItemNewsWidget(news);
                },
              ).toList());
            }
          },
        ),
      );
}
