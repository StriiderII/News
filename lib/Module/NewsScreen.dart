import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_route/cubit/NewCubit.dart';
import 'package:news_app_route/cubit/NewsState.dart';
import 'package:news_app_route/Widget/ArticleNewsScreen.dart';
import 'package:news_app_route/Widget/DefaultTabBarWidget.dart';

// ignore: must_be_immutable
class NewsScreen extends StatelessWidget {
  static const String routeName = 'news_screen';

  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getSources(NewsCubit.get(context).catergorieModel?.id ?? 'sports'),
      child: BlocConsumer<NewsCubit, HomeState>(listener: (context, state) {
        if (state is HomeLoadindState) {
          const Center(child: CircularProgressIndicator());
        } else if (state is HomeSorcesErrorState) {
          const Center(
            child: Text('No News'),
          );
        } else if (state is HomeSorcesSuccessState) {
          NewsCubit.get(context).getNewsData();
        }
      }, builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Column(
          children: [
            const TabBarWidget(),

            Expanded(
              child: ListView.builder(
                itemCount: cubit.articlesList.length,
                itemBuilder: (context, index) {
                  return ArticlesNewsWidget(
                    articles: NewsCubit.get(context).articlesList[index],
                  );
                },
              ),
            )


          ],
        );
      }),
    );

  }
}

