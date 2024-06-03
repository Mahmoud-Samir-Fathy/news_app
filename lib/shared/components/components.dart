
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:news_app/news_pages/webview_page.dart';



Widget defaultButton({
  double conthight=70,
  double width=double.infinity,
  double radius=5,
  Color color=Colors.blue,
  required String text,
  required Function,
  bool isUpperCase=true,
})=>Container(
  height: conthight,
  width: width,
  child:
  MaterialButton(
    onPressed: Function,
    child: Text(isUpperCase?text.toUpperCase():text,style: TextStyle(color: Colors.white),),
  ),
  decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(radius),
      color: color
  ),
);

Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType? KeyboardType,
  Function(String)? onChanged,
  Function(String)? onSubmit,
  VoidCallback?onTap,
  required String? Function(String?)? validate,
  required String? lable,
  required IconData? prefix,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixpressed,
})=>TextFormField(
  controller: controller,
  keyboardType: KeyboardType,
  obscureText: isPassword,
  onChanged:onChanged,
  onFieldSubmitted:onSubmit,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    prefixIcon: Icon(prefix),
    labelText: lable,
    border: OutlineInputBorder(),
    suffixIcon: suffix !=null?IconButton(icon: Icon(suffix),onPressed: suffixpressed,):null,

  ),
);



Widget mySeparator()=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    color: Colors.grey,
    height: 1,
    width: double.infinity,
  ),
);

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebviewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Container(
          width: 140,
          height: 130,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
           image: DecorationImage(
              image: NetworkImage('${article['urlToImage'] !=null?article['urlToImage']:'https://d3544la1u8djza.cloudfront.net/APHI/Blog/2021/07-06/small+white+fluffy+dog+smiling+at+the+camera+in+close-up-min.jpg' }'),
                fit: BoxFit.cover
             )
         ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text('${article['title']}',style:TextStyle(fontWeight: FontWeight.w700,fontSize: 20),maxLines: 3,overflow:TextOverflow.ellipsis ),),
                Text('${article['publishedAt']}',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400)),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);


Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
    condition: list.length>0,
    builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder:(context,index)=> buildArticleItem(list[index],context) ,
      separatorBuilder:(context,index)=> mySeparator(),
      itemCount: list.length,
    ),
    fallback: (context)=>isSearch?Container():Center(child: CircularProgressIndicator(color: Colors.deepOrange,)));


void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}
void navigateAndFinish(context,widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}

void showToast(context,{
  required String title,
  required String description,
  required ToastColorState state,
  required IconData icon,

})=> MotionToast(
  icon: icon,
  title: Text(title),
  description: Text(description,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  animationType: AnimationType.fromBottom,
  animationCurve: Curves.decelerate,
  primaryColor: chooseToastColor(state),
  dismissable: true,
).show(context);

enum ToastColorState{success,error,warning}

Color chooseToastColor(ToastColorState state){
  Color color;
  switch (state)
  {
    case ToastColorState.success:
       color=Colors.green;
        break;
       case ToastColorState.error:
       color=Colors.red;
       break;
    case ToastColorState.warning:
       color=Colors.amber;
       break;
  }
   return color;
}
