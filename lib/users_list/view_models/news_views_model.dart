import 'package:flutter/material.dart';
import 'package:news_app/users_list/models/news_list_model.dart';
import 'package:news_app/users_list/models/user_error.dart';
import 'package:news_app/users_list/models/users_list_model.dart';
import 'package:news_app/users_list/repo/api_status.dart';
import 'package:news_app/users_list/repo/news_service.dart';

class NewsViewModel with ChangeNotifier {
  //
  bool? _loading;
  String? categories;
  UserError? _userError;
  late NewsModel _selectedNews;
  late UserModel _addingUser;
  late List<NewsModel> _business = [];
  List<NewsModel> get business => _business;
  bool? get loading => _loading;
  UserError? get userError => _userError;
  NewsModel get selectedNews => _selectedNews;
  UserModel get addingUser => _addingUser;
  void setLoading(loading1) {
    _loading = loading1;
    notifyListeners();
  }

  NewsViewModel() {
    getNews();
    notifyListeners();
  }
  setNewsListModel(List<NewsModel> userListModel) {
    _business = userListModel;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  setSelectedNews(NewsModel userModel) {
    _selectedNews = userModel;
    notifyListeners();
  }

  Future<void> getNews() async {
    setLoading(true);

    print("categories");
    print(categories);
    var response = await NewsServices.getNews(categories);
    if (response is Success) {
      setNewsListModel(response.response as List<NewsModel>);
      setLoading(false);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
    }
    setLoading(false);
    notifyListeners();
  }

  void setCategory(String cat) {
    categories = cat;
  }
}
