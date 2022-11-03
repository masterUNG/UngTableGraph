// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungtablegraph/widgets/widget_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String message,
    Widget? textButton1,
    Widget? textButton2,
  }) {
    Get.dialog(
      AlertDialog(
        title: WidgetText(text: title),
        content: WidgetText(text: message),
        actions: [
          textButton1 ?? const SizedBox(),
          textButton2 ?? const SizedBox(),
        ],
      ),
    );
  }
}
