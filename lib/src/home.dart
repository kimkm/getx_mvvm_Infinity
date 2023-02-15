import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm_sample/src/controller/home_controller.dart';
import 'package:flutter_getx_mvvm_sample/src/model/random_user_simple.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Home extends GetView<HomeController> {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX_MVVM_무한스크롤'),
        centerTitle: true,
      ),
      body: _userListWidget(),
      // bottomNavigationBar: _bottomBtn(),
    );
  }

  Widget _bottomBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: controller.loadSimpleUser, child: const Text('사용자 로드')),
    );
  }

  Widget _userListWidget() {
    return Obx(
      () => SingleChildScrollView(
        controller: controller.scrollController.value,
        child: Column(
          children: [
            Column(
              children: List.generate(
                controller.userList.length,
                (index) => _userSimpleWidget(controller.userList[index], index),
              ),
            ),
            if (controller.tg.value == false)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _userSimpleWidget(RandomUserSimple user, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            (index + 1).toString().padLeft(3, '0'),
            style: TextStyle(fontSize: 20),
          ),
          Image.network(user.thumbnail ?? '', height: 80, fit: BoxFit.fill),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.fullname}',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 5),
              Text(
                '${user.phone}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
