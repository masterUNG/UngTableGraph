import 'package:dio/dio.dart';

class MyService {

  Future<void> insertNumber({required String number}) async {
    String urlApi = 'https://www.androidthai.in.th/fluttertraining/insertNumberUng.php?isAdd=true&number=$number';

    await Dio().get(urlApi).then((value) => print('Insert number Success'));

  }

}
