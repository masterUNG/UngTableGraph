import 'package:flutter/material.dart';
import 'package:ungtablegraph/utility/my_dialog.dart';
import 'package:ungtablegraph/utility/my_service.dart';
import 'package:ungtablegraph/widgets/widget_button.dart';
import 'package:ungtablegraph/widgets/widget_form.dart';
import 'package:ungtablegraph/widgets/widget_text.dart';

class MyTable extends StatefulWidget {
  const MyTable({super.key});

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  String? number;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: SizedBox(
          width: boxConstraints.maxWidth,
          height: boxConstraints.maxHeight,
          child: Stack(
            children: [
              WidgetText(text: 'This is List Value'),
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
      );
    });
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
    });
  }
}
