import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:karty/shared/constants/colors.dart';
import 'package:karty/shared/constants/constants.dart';
import 'package:karty/shared/cubit/home_states.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context)=>BlocProvider.of(context);


  List<Media>? listImagePaths;
  Future<void> selectImages() async {
    emit(HomeSelectImageLoadingState());
     await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: mainColor),
        cropConfig: CropConfig(enableCrop: true, width: 7, height: 1)).then((value) {
          listImagePaths=value;
          emit(HomeSelectImageSuccessState());
    }).catchError((error){
      emit(HomeSelectImageErrorState());
     });
  }
 String? cardNumber;
  Future<void>extractNumber(String kindCode)async{
    emit(HomeExtractTextLoadingState());
    await selectImages().then((value)async {
      cardNumber=  await FlutterTesseractOcr.extractText(listImagePaths![0].path!, language: 'kor+eng',

      ).catchError((error){
        emit(HomeExtractTextErrorState());
      });

    });
    print(cardNumber);

    cardNumber!.replaceAll(RegExp(regex, unicode: true),'');
    makeTheCodeReady(kindCode);


  }

  String ?readyCardNumber;

 Future<void>makeTheCodeReady(String kindCode)async{

    readyCardNumber= kindCode.replaceAll('كود الشحن', cardNumber!);
    print(readyCardNumber);
    makePhoneCall(readyCardNumber!);

    emit(HomeMakeCodeReadyState());

 }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

}