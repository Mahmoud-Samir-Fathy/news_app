import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/application_cubit.dart';
import 'package:news_app/application_state.dart';
import 'package:news_app/news_layout/news_app/news_app_layout.dart';
import 'package:news_app/news_layout/news_app/news_cubit.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/network/local/cashe_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key:'isDark');
;
  runApp(Myapp(
    isDark: isDark,
  ));
}
class Myapp extends StatelessWidget{
  final bool? isDark;
  Myapp({this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getTesla()..getBusiness()..getTechCrunch()),
        BlocProvider( create: (BuildContext context) =>ApplicationCubit()..changeMode(fromShared:  isDark),),
      ],
      child: BlocConsumer<ApplicationCubit,ApplicationState>(
        listener: (BuildContext context,ApplicationState state){
        },
        builder:(
            BuildContext context,ApplicationState state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme:darkMode ,
              themeMode:ApplicationCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
              home:NewsApp()
          );
        } ,
      ),
    );
  }
}