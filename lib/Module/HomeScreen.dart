import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_route/Origin/CasheHelper.dart';
import 'package:news_app_route/cubit/NewCubit.dart';
import 'package:news_app_route/cubit/NewsState.dart';
import 'package:news_app_route/models/categories_mode.dart';
import 'package:news_app_route/Module/NewsScreen.dart';
import 'package:news_app_route/Module/SearchScreen.dart';
import 'package:news_app_route/Widget/DarwerWidget.dart';
import 'package:news_app_route/Widget/GridViewItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CatergorieModel> categories = [
    CatergorieModel(
      name: 'Sports',
      image: 'assets/images/sports.png',
      id: 'sports',
      color: const Color(0xffC91C22),
    ),
    CatergorieModel(
      name: 'Politces',
      image: 'assets/images/politics.png',
      id: 'general',
      color: const Color(0xff003E90),
    ),
    CatergorieModel(
      name: 'Health',
      image: 'assets/images/health.png',
      id: 'health',
      color: const Color(0xffED1E79),
    ),
    CatergorieModel(
      name: 'Bussiens',
      image: 'assets/images/bussines.png',
      id: 'business',
      color: const Color(0xffCF7E48),
    ),
    CatergorieModel(
      name: 'Entertainment',
      image: 'assets/images/environment.png',
      id: 'entertainment',
      color: const Color(0xff4882CF),
    ),
    CatergorieModel(
      name: 'Science',
      image: 'assets/images/science.png',
      id: 'science',
      color: const Color(0xffF2D352),
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/pattern.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
              title: Text(
                NewsCubit.get(context).catergorieModel == null
                    ? 'News App'
                    : NewsCubit.get(context).catergorieModel!.name,
                style:
                    GoogleFonts.exo(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            drawer: DarwerWidget(
              makeModelNull: NewsCubit.get(context).makeModelNull,
            ),
            body: NewsCubit.get(context).catergorieModel == null &&
                    CasheHelper.getData('news') == null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pick your Category \n of your intrest',
                          style: GoogleFonts.poppins(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .79,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 18),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GridViewItemWidget(
                                  OnClick: NewsCubit.get(context).onClick,
                                  index: index,
                                  catergorieModel: categories[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : NewsScreen(
                    ),
          ),
        );
      },
    );
  }
}
