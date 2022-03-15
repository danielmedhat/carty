import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karty/shared/constants/colors.dart';
import 'package:karty/shared/constants/constants.dart';
import 'package:karty/shared/cubit/home_cubit.dart';
import 'package:karty/shared/cubit/home_states.dart';

class HomePage extends StatelessWidget {
var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =HomeCubit.get(context);
          ImagePicker? imagePicker=ImagePicker();
          return Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Center(child: Text('اشحن الكارت بسهولة مع  Carty',style: TextStyle(fontSize: 40,color: Colors.white),textAlign:TextAlign.center ,)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        color: mainColor),
                    width: double.infinity,
                    height: 400,
                  ),
                  GridView.count(
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      buildGridItem(cubit,'Vodafone',
                          'https://www.3allemni.com/wp-content/uploads/2021/01/6_vodafone_uk_2016.png',imagePicker!,context,0),
                      buildGridItem(cubit,'Orange',
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Orange_logo.svg/1200px-Orange_logo.svg.png',imagePicker,context,1),
                      buildGridItem(cubit,'Etisalat',
                          'https://www.albayan.ae/polopoly_fs/1.3813619.1585253711!/image/image.jpg',imagePicker,context,2),
                      buildGridItem(cubit,
                        'We',
                        'https://yt3.ggpht.com/ytc/AKedOLR3EHuKGuNIud2gYk-vCLL3VlKfYZUhDVucIuUGOA=s900-c-k-c0x00ffffff-no-rj',imagePicker,context,3
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
Widget buildGridItem(HomeCubit cubit,String text, String icon,ImagePicker imagePicker,BuildContext context,int index) {
    return InkWell(
      onTap: ()async {
        scaffoldKey.currentState!.showBottomSheet((context) =>buildBottomSheet(context, cubit,kinds[index],kindCodes[index]) );
         // cubit.selectImages();
         },
      child: Card(
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.network(
                  icon,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 20, color: Color(0xff5b41b6)),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget buildBottomSheet(BuildContext context,HomeCubit cubit,List<String>kinds,List<String>kindCodes){
    return BottomSheet(onClosing: (){},enableDrag: false, builder:(context){
      return Container(
        decoration: BoxDecoration(
          color: mainDarkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        height: 200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              itemBuilder:(context,index)=>buildListViewItem(kinds[index],kindCodes[index],cubit,context) ,
              separatorBuilder:(context,index)=> SizedBox(width: 1,),
              itemCount: kinds.length),
        ),
      );
    });
  }
  Widget buildListViewItem(String kind,String kindCode,HomeCubit cubit,BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 10,right: 10,left: 10),
      child: InkWell(
        onTap: () async {
          showDialog(context: context, builder: (context)=>SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              title: Text('حدد الكود فقط '),

              
              children: [
                SimpleDialogOption(
                  child: Container(
                    height: 120,
                    width: 140,
                    child: Image.network(
                        'https://rasd-presse.com/wp-content/uploads/2021/10/%D8%B4%D8%AD%D9%86-%D9%83%D8%A7%D8%B1%D8%AA-%D9%81%D9%88%D8%AF%D8%A7%D9%81%D9%88%D9%86-%D8%A8%D8%A3%D9%83%D8%AB%D8%B1-%D9%85%D9%86-%D8%B7%D8%B1%D9%8A%D9%82%D8%A9...jpg',fit: BoxFit.cover,),
                  ),
                ),
                SimpleDialogOption(child: RaisedButton(onPressed: (){
                  Navigator.pop(context);
                  cubit.extractNumber(kindCode);
                },color: mainColor,child: Text('OK',style: TextStyle(color: Colors.white),),),)
              ]));

           //
        },
        child: Container(
          height: 120,
          width: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: mainColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(child: Text(kind,style: TextStyle(fontSize: 35,color: Colors.white),)),
              SizedBox(height: 5,),
              FittedBox(
                child: Text(kindCode,style: TextStyle(fontSize: 25,color: Colors.white),),

              )
            ],
          ),
        ),
      ),
    );
  }
}
