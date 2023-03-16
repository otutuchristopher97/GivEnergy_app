class BatteryModel {
  String? serial, status, type;
  double? current, voltage;
  int? percentage;
  String? lastOnline, lastUpdated, expiryDate, commissionDate;

  BatteryModel({
    this.current,
    this.expiryDate,
    this.lastOnline,
    this.lastUpdated,
    this.percentage,
    this.serial,
    this.status,
    this.type,
    this.voltage,
    this.commissionDate
  });
}


// {
//         "serial": "GV3022G001",
//         "status": "ONLINE",
//         "last_online": "2021-07-18T01:25:18Z",
//         "last_updated": "2021-07-19T00:41:12Z",
//         "commission_date": "2021-07-13T00:00:00Z",
//         "warranty": {
//             "type": "Standard",
//             "expiry_date": "2026-07-13T00:00:00Z"
//         },
//         "values": {
//             "current": 10.8,
//             "voltage": 59.2,
//             "percentage": 90,
//         }
//     }