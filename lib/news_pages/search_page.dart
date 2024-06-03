import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_layout/news_app/news_cubit.dart';
import 'package:news_app/news_layout/news_app/news_states.dart';
import 'package:news_app/shared/components/components.dart';


class SearchNews extends StatelessWidget{
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state){},
     builder:(context,state){
       var list=NewsCubit.get(context).search;
       return Scaffold(
         appBar: AppBar(),
         body: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: defaultTextFormField(
                   controller: searchController,
                   KeyboardType: TextInputType.text,
                   onChanged: (value){
                     NewsCubit.get(context).getSearch(value);
                   },
                   validate: (value){
                     if(value!.isEmpty){
                      return'Search Must not be empty';
                     }
                     return null;
                   },
                   lable: 'Search',
                   prefix: Icons.search),
             ),
             Expanded(child: articleBuilder(list, context,isSearch: true))
           ],
         ),
       );
     } ,

   );
  }

}