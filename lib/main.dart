import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_route/Origin/AppTheme/app_theme.dart';
import 'package:news_app_route/Origin/CasheHelper.dart';
import 'package:news_app_route/cubit/NewCubit.dart';
import 'package:news_app_route/cubit/SearchCubit.dart';
import 'package:news_app_route/Module/HomeScreen.dart';
import 'package:news_app_route/Module/NewsScreen.dart';
import 'package:news_app_route/Module/SearchScreen.dart';
import 'package:news_app_route/Module/SplashScreen.dart';
import 'package:news_app_route/MyBlocObserv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CasheHelper.init();
  String? cashe = CasheHelper.getData('news');
  String start;
  if (cashe  == null) {
    start = SplashScreen.routeName;
  } else {
    start = HomeScreen.routeName;
  }
  runApp(
    NewsApp(
      startWidget: start,
    ),
  );
  Bloc.observer = MyBlocObserver();
}

class NewsApp extends StatelessWidget {
  String startWidget;
  NewsApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.appTheme(MediaQuery.of(context)),
        debugShowCheckedModeBanner: false,
        initialRoute: startWidget,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          NewsScreen.routeName: (context) => NewsScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
        },
      ),
    );
  }
}
