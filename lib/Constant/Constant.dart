import 'package:news_app_route/Origin/CasheHelper.dart';

class Constant {
  static const String apiKey = 'f4f949f1fef6467ca03b05af4d492650';
  static const String baseUrl = 'newsapi.org';
  static const String topHeadlines = '/v2/top-headlines/sources';
  static const String everything = '/v2/everything';
  static const String sources = '/v2/sources';

  static String? cashe = CasheHelper.getData('news');
}
