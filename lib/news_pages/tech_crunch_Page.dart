import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_layout/news_app/news_cubit.dart';
import 'package:news_app/news_layout/news_app/news_states.dart';
import 'package:news_app/shared/components/components.dart';


class TechCrunch_Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){

        var list=NewsCubit.get(context).techcrunch;
        return articleBuilder(list,context);
      },
    );
  }
}