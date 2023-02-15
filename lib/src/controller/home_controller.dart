import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm_sample/src/model/random_user_simple.dart';
import 'package:flutter_getx_mvvm_sample/src/repository/random_user_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late RandomUserRepository _randomUserRepository;
  var scrollController = ScrollController().obs;
  RxList<RandomUserSimple> userList = <RandomUserSimple>[].obs;
  RxBool tg = true.obs;

@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadSimpleUser();
  }

  @override
  void onInit() {
    super.onInit();
    _randomUserRepository = RandomUserRepository();
    this.scrollController.value.addListener(() {
      double nowsize = this.scrollController.value.position.pixels;
      double maxsize = this.scrollController.value.position.maxScrollExtent;
      if ((maxsize - nowsize) < 1000 && tg.value == true) {
        tg(false);
        loadSimpleUser();
      }
      if ((maxsize - nowsize) > 1000 && tg.value == false) {
        tg(true);
      }
      // print('now: ${nowsize.toString()}');
      // print('max: ${maxsize.toString()}');
    });
  }

  void loadSimpleUser() async {
    var users = await _randomUserRepository.getAllUserWithSimple();
    userList([...userList, ...users]);
    // print('---------------loadSimpleUwer---------------');
  }
}
