import 'news_model.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<NewsModel> articles;

  NewsResponse(this.status, this.totalResults, this.articles);

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var newsJsonList = json['articles'] as List;
    List<NewsModel> newList =
        newsJsonList.map((i) => NewsModel.fromJson(i)).toList();
    return NewsResponse(json['status'], json['totalResults'], newList);
  }
}
