import 'package:flutter/material.dart';

class MyConstant {

  TextStyle h1Style() => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      );

       TextStyle h2Style() => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

       TextStyle h3Style({Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
      );








}
