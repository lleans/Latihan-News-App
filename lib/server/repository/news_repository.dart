import 'package:NewsAppLatihanEzyIndustries/model/news_response.dart';
import 'package:NewsAppLatihanEzyIndustries/server/end_points.dart';
import 'package:NewsAppLatihanEzyIndustries/server/api_exception.dart';
import 'package:NewsAppLatihanEzyIndustries/server/http_client.dart';

class NewsRepository { 
  final HttpClient _httpClient = HttpClient();

  @override
  Future<NewsResponse> getAllNews() async {
    final dynamic newsJson = 
      await _httpClient.getRequest(EndPoints.allNews);

    if (newsJson.isEmpty) {
      throw EmptyResultException();
    }
    
    return NewsResponse.fromJson(newsJson);
  }
}