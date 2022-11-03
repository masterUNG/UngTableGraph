import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungtablegraph/controllers/app_controller.dart';
import 'package:ungtablegraph/utility/my_constant.dart';
import 'package:ungtablegraph/utility/my_dialog.dart';
import 'package:ungtablegraph/utility/my_service.dart';
import 'package:ungtablegraph/widgets/widget_button.dart';
import 'package:ungtablegraph/widgets/widget_form.dart';
import 'package:ungtablegraph/widgets/widget_icon_button.dart';
import 'package:ungtablegraph/widgets/widget_text.dart';
import 'package:ungtablegraph/widgets/widget_text_button.dart';

class MyTable extends StatefulWidget {
  const MyTable({super.key});

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  String? number;
  TextEditingController textEditingController = TextEditingController();

  final appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    appController.readAllNumber();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (controller) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    FocusScope.of(context).requestFocus(FocusScopeNode()),
                child: SizedBox(
                  width: boxConstraints.maxWidth,
                  height: boxConstraints.maxHeight,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: boxConstraints.maxHeight - 80,
                        child: ListView(
                          children: [
                            head(),
                            listNumber(controller),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Row(
                          children: [
                            valueForm(boxConstraints),
                            addButton(boxConstraints)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    });
  }

  ListView listNumber(AppController controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: controller.numberModels.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetText(text: controller.numberModels[index].id),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: WidgetText(text: controller.numberModels[index].number),
              ),
              Expanded(
                flex: 1,
                child: WidgetTextButton(
                  label: 'Edit',
                  pressFunc: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: WidgetIconButton(
                  iconData: Icons.delete_forever,
                  pressFunc: () {
                    print(
                        'delete at id --> ${controller.numberModels[index].id}');

                    MyDialog(context: context).normalDialog(
                      title: 'Confirm Delete',
                      message:
                          'Delete at id = ${controller.numberModels[index].id} \nnumber = ${controller.numberModels[index].number}',
                      textButton1: WidgetTextButton(
                        label: 'Delete',
                        pressFunc: () async {
                          await MyService()
                              .deleteNumber(
                                  id: controller.numberModels[index].id)
                              .then((value) {
                            controller.readAllNumber();
                            Get.back();
                          });
                        },
                      ),
                      textButton2: WidgetTextButton(
                        label: 'Cancel',
                        pressFunc: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }

  Container head() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: Color.fromARGB(255, 198, 186, 186)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetText(
                  text: 'id',
                  textStyle: MyConstant().h2Style(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: WidgetText(
              text: 'Number',
              textStyle: MyConstant().h2Style(),
            ),
          ),
        ],
      ),
    );
  }

  Container addButton(BoxConstraints boxConstraints) {
    return Container(
      padding: const EdgeInsets.only(right: 16),
      width: boxConstraints.maxWidth * 0.25,
      height: 50,
      child: WidgetButton(
        label: 'Add',
        pressFunc: () {
          if (number?.isEmpty ?? true) {
            print('Have Space');
            MyDialog(context: context).normalDialog(
                title: 'Have Space ?', message: 'Please Fill Every Blank');
          } else {
            print('No Space');
            processInsertValueToApi();
          }
        },
      ),
    );
  }

  Container valueForm(BoxConstraints boxConstraints) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      width: boxConstraints.maxWidth * 0.75,
      child: WidgetForm(
        textEditingController: textEditingController,
        hint: 'Number',
        textInputType: TextInputType.number,
        changeFunc: (String string) {
          number = string.trim();
        },
      ),
    );
  }

  Future<void> processInsertValueToApi() async {
    await MyService().insertNumber(number: number!).then((value) {
      textEditingController.text = '';
      appController.readAllNumber();
    });
  }
}
