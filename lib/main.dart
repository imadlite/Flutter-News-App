import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/users_list/view_models/news_views_model.dart';
import 'package:news_app/utils/cache_helper.dart';
import 'package:news_app/utils/diohelper.dart';
import 'package:provider/provider.dart';
import 'users_list/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
      ],
      child: MaterialApp(
        title: 'News_App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(
          cat: "",
        ),
      ),
    );
  }
}
