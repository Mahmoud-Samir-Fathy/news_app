abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsChangeBottomNavBar extends NewsStates{}

class NewsGetTeslaLoadingState extends NewsStates{}
class NewsGetTeslaSuccessState extends NewsStates{}
class NewsGetTeslaErrorState extends NewsStates{
  final String error;

  NewsGetTeslaErrorState(this.error);

}

class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{
  final String error;

  NewsGetBusinessErrorState(this.error);


}

class NewsGetTechCrunchLoadingState extends NewsStates{}
class NewsGetTechCrunchSuccessState extends NewsStates{}
class NewsGetTechCrunchErrorState extends NewsStates{
  final String error;

  NewsGetTechCrunchErrorState(this.error);


}

class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{
  final String error;

  NewsGetSearchErrorState(this.error);



}
