import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karty/modules/home_page.dart';
import 'package:karty/shared/cubit/home_cubit.dart';
import 'package:karty/shared/cubit/home_states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            title: 'Flutter Demo',
            home: HomePage(),
          );
        },

      ),
    );
  }
}

