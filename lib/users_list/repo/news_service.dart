import 'dart:io';
import 'package:dio/src/response.dart';
import 'package:news_app/users_list/models/news_list_model.dart';
import 'package:news_app/users_list/models/users_list_model.dart';
import 'package:news_app/users_list/repo/api_status.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/diohelper.dart';

class NewsServices {
  // categories=[health,sport,bu]
  static Future<Object> getNews(cat) async {
    try {
      print(cat);
      Response response = await DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'category': cat,
          'apiKey': '10816814cf124ac6801abdea37b1d241',
        },
      );
      if (SUCCESS == response.statusCode) {
        return Success(
            response: newsListModelFromJson(response.data["articles"]),
            code: response.statusCode!);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
