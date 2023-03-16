import 'package:flutter/material.dart';
import 'package:givenergy_app/features/data/models/battery_model.dart';
import 'package:givenergy_app/features/data/datasources/task_api.dart';

class BatteryProvider extends ChangeNotifier {
  List<BatteryModel> tasks = BatteryApiJsonCall.instance.tasks;

  // addTask(BatteryModel model) {
  //   BatteryApiJsonCall.instance.getBatteries();
  //   notifyListeners();
  // }
}
