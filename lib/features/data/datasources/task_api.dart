// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/battery_model.dart';

class BatteryApiJsonCall {
  BatteryApiJsonCall._privateConstructor();

  static final BatteryApiJsonCall instance =
      BatteryApiJsonCall._privateConstructor();

  List<BatteryModel> _batteries = [];

  double totalPower = 0;
  double averagePercentage = 0;

  List<BatteryModel> get tasks {
    return [..._batteries];
  }

  Future<void> getBatteries() async {
    await Future.delayed(const Duration(seconds: 3));
    final String response =
        await rootBundle.loadString('assets/batteries/ten batteries.json');
    var resData = await jsonDecode(response.toString());
    List<dynamic> entities = resData["data"];
    totalPower = 0;
    averagePercentage = 0;
    num power = 0;
    num percentage = 0;
    for (var entity in entities) {
      BatteryModel itemcategory = BatteryModel();

      itemcategory.serial = entity["serial"] ?? "";
      itemcategory.status = entity["status"] ?? "";
      itemcategory.lastOnline = entity["last_online"];
      itemcategory.lastUpdated = entity["last_updated"];
      itemcategory.commissionDate = entity["commission_date"];
      itemcategory.type = entity["warranty"]["type"] ?? "";
      itemcategory.expiryDate = entity["warranty"]["expiry_date"];
      itemcategory.current =
          double.parse(entity["values"]["current"].toString());
      itemcategory.voltage =
          double.parse(entity["values"]["voltage"].toString());
      itemcategory.percentage = entity["values"]["percentage"] ?? 0;

      power = power + entity["values"]["voltage"];
      percentage = percentage + entity["values"]["percentage"];

      _batteries.add(itemcategory);
    }

    totalPower = power.toDouble();
    print(totalPower);
    averagePercentage = percentage / _batteries.length;
  }

  List<BatteryModel> searchByName(String name) {
    totalPower = 0;
    averagePercentage = 0;
    num power = 0;
    num percentage = 0;
    if (name.isEmpty) {
      _batteries.forEach((element) {
        power = power + element.voltage!;
        percentage = percentage + element.percentage!;
      });
      totalPower = power.toDouble();
      print(totalPower);
      averagePercentage = percentage / _batteries.length;
      return _batteries;
    } else {
      totalPower = 0;
      averagePercentage = 0;
      var data = _batteries
          .where((value) => (value.serial
                  .toString()
                  .toLowerCase()
                  .contains(name.toLowerCase()) ||
              value.status
                  .toString()
                  .toLowerCase()
                  .contains(name.toLowerCase())))
          .toList();
      data.forEach((element) {
        power = power + element.voltage!;
        percentage = percentage + element.percentage!;
      });
      totalPower = power.toDouble();
      print(totalPower);
      averagePercentage = percentage / _batteries.length;
      return data;
    }
  }

  // deleteTask(TaskModel model) {
  //   tasks.removeWhere((element)=> element.title == model.title );
  // }
}
