import 'package:dio/dio.dart';

class MyService {
  Future<void> editNumber({required String id, required String number}) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/editNumberWhereIdUng.php?isAdd=true&id=$id&number=$number';
    await Dio().get(urlAPI);
  }

  Future<void> deleteNumber({required String id}) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/deleteWhereIdUng.php?isAdd=true&id=$id';

    await Dio().get(urlAPI).then((value) {
      print('Delete number Success');
    });
  }

  Future<void> insertNumber({required String number}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/insertNumberUng.php?isAdd=true&number=$number';

    await Dio().get(urlApi).then((value) => print('Insert number Success'));
  }
}
