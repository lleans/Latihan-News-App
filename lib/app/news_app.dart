import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'package:NewsAppLatihanEzyIndustries/ui/screen/main_page.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      theme: AppThemeDataFactory.prepareThemeData(),
      home: MainPage(title: "News App"),
    );
  }
}