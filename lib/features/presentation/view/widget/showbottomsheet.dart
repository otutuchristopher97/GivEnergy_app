import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/battery_model.dart';

class ShareButtomSheetView extends StatelessWidget {
  BatteryModel? batteryModel;
  ShareButtomSheetView({Key? key, this.batteryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.43,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Battery ${batteryModel!.serial.toString()}',
              style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                batteryModel!.status.toString(),
                style: TextStyle(
                    color: batteryModel!.status.toString() == "ONLINE"
                        ? const Color(0xff4CC0AB)
                        : Colors.red[200],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last Online',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                DateFormat("MMM d, y").format(
                    DateTime.parse(batteryModel!.lastOnline.toString())),
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date Commissioned',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                DateFormat("MMM d, y").format(
                    DateTime.parse(batteryModel!.expiryDate.toString())),
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Warranty Exire Date',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Year ${DateFormat("yyyy").format(DateTime.parse(batteryModel!.expiryDate.toString()))}',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Power',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${batteryModel!.voltage}W",
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Percentage',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${batteryModel!.percentage}%",
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
