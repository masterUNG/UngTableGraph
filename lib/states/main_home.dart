import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungtablegraph/controllers/app_controller.dart';
import 'package:ungtablegraph/states/about_me.dart';
import 'package:ungtablegraph/widgets/graph.dart';
import 'package:ungtablegraph/widgets/my_table.dart';
import 'package:ungtablegraph/widgets/widget_icon_button.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var titles = <String>[
    'Table',
    'Graph',
  ];

  var iconDatas = <IconData>[
    Icons.table_chart,
    Icons.graphic_eq,
  ];

  var bodys = <Widget>[
    const MyTable(),
    const Graph(),
  ];

  var bottonNavigationBarItems = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < titles.length; i++) {
      bottonNavigationBarItems.add(
        BottomNavigationBarItem(
            icon: Icon(
              iconDatas[i],
            ),
            label: titles[i]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(titles[controller.indexBodys.value]),
              actions: [
                WidgetIconButton(
                  iconData: Icons.face,
                  pressFunc: () {
                    // Get.to(const AboutMe()); // Can Back
                    Get.off(const AboutMe()); // Cannot Back
                  },
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottonNavigationBarItems,
              currentIndex: controller.indexBodys.value,
              onTap: (value) {
                controller.indexBodys.value = value;
              },
            ),
            body: bodys[controller.indexBodys.value],
          );
        });
  }
}
