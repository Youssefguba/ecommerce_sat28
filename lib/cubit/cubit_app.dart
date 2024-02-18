import 'package:ecommerce_trining/cubit/cubit_states.dart';
import 'package:ecommerce_trining/modules/home/homepage.dart';
import 'package:ecommerce_trining/modules/screens/accountpage.dart';
import 'package:ecommerce_trining/modules/screens/cartpage.dart';
import 'package:ecommerce_trining/modules/screens/explore.dart';
import 'package:ecommerce_trining/modules/screens/offerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(initialState());


  //متغير هياخد رقم الانديكس الخاص بالايتم بوتم بار
  int currentIndex = 0;

  //هعمل ليست للصفحات اللي هتنقل فيها علشان امررها للبوتن بار
  List<Widget> screens = [
    HomePage(),
    ExplorePage(),
    CartPage(),
    OfferPage(),
    AccountPage(),
  ];

  void selectPaga (int index){
    currentIndex = index;
    emit(BottomNavBarState());
  }
  

}