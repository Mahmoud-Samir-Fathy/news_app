import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/application_cubit.dart';
import 'package:news_app/news_layout/news_app/news_cubit.dart';
import 'package:news_app/news_layout/news_app/news_states.dart';
import 'package:news_app/news_pages/search_page.dart';
import 'package:news_app/shared/components/components.dart';


class NewsApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
     listener:(context,state){} ,
      builder: (context,state){
       var cubit=NewsCubit.get(context);


       return
        Scaffold(
          appBar: AppBar(
            title: Text('News App')
            ,actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchNews());
            }, icon: Icon(Icons.search)),
            IconButton(onPressed: () {
              ApplicationCubit.get(context).changeMode();

            },
                icon: Icon(Icons.brightness_4_outlined))
          ],
          ),
          bottomNavigationBar:BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomList,
            onTap: (index){
              cubit.ChangeBotttomNav(index);
            },
          ),
          body: cubit.NewsScreens[cubit.currentIndex],

        );
      },
      );
  }


}