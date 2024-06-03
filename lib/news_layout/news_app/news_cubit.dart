import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_layout/news_app/news_states.dart';
import 'package:news_app/news_pages/business_page.dart';
import 'package:news_app/news_pages/tech_crunch_Page.dart';
import 'package:news_app/news_pages/tesla_page.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{

  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomList=[
    BottomNavigationBarItem(icon:Icon(Icons.car_crash_outlined) ,label:'Tesla' ),
    BottomNavigationBarItem(icon:Icon(Icons.business) ,label:'Business' ),
    BottomNavigationBarItem(icon:Icon(Icons.rocket_outlined) ,label:'TechCrunch' ),
  ];

  List<Widget> NewsScreens=[
    Tesla_Page(),
    Business_Page(),
    TechCrunch_Page(),
  ];

  void ChangeBotttomNav(int index){
    currentIndex=index;
    if(index==1) getBusiness();
    if(index==2) getTechCrunch();
    emit(NewsChangeBottomNavBar());

  }

  List<dynamic> tesla=[];

  void getTesla(){
    emit(NewsGetTeslaLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'tesla',
          'from':'2024-01-14',
          'sortBy':'publishedAt',
          'apiKey':'e11e0e403f644fd69757cce4ee9f46d5'
        }).then((value) {
      tesla=value!.data['articles'];
      emit(NewsGetTeslaSuccessState());
    }).catchError((error){
      emit(NewsGetTeslaErrorState(error.toString()));
      print(error.toString());

    }) ;
  }

  List<dynamic> business=[];

  void getBusiness(){

    emit(NewsGetBusinessLoadingState());

    if(business.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'business',
            'apiKey':'e11e0e403f644fd69757cce4ee9f46d5'
          }).then((value) {
        business=value!.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        emit(NewsGetBusinessErrorState(error.toString()));
        print(error.toString());

      }) ;
    }else {
      emit(NewsGetBusinessSuccessState());
    }

  }

  List<dynamic> techcrunch =[];

  void getTechCrunch (){
    emit(NewsGetTechCrunchLoadingState());
    if(techcrunch.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'sources':'techcrunch',
            'apiKey':'e11e0e403f644fd69757cce4ee9f46d5'
          }).then((value) {
        techcrunch=value!.data['articles'];
        emit(NewsGetTechCrunchSuccessState());
      }).catchError((error){
        emit(NewsGetTechCrunchErrorState(error.toString()));
        print(error.toString());

      }) ;
    } else {
      emit(NewsGetTechCrunchSuccessState());
    }

  }

  List<dynamic> search =[];
  void getSearch (String value){
    emit(NewsGetSearchLoadingState());
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':value,
            'apiKey':'e11e0e403f644fd69757cce4ee9f46d5'
          }).then((value) {
        search=value!.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        emit(NewsGetSearchErrorState(error.toString()));
        print(error.toString());

      }) ;

  }

}