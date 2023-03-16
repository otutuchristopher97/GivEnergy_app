part of 'battery_bloc.dart';

abstract class BatteryState extends Equatable {
  const BatteryState();

  @override
  List<Object> get props => [];
}

class BatteryInitial extends BatteryState {}

class BatteryLoading extends BatteryState {}

class BatteryLoaded extends BatteryState {
  final List<BatteryModel> batteryModel;
  final double totalPower;
  final double averagePercentage;

  const BatteryLoaded({required this.batteryModel, required this.totalPower, required this.averagePercentage, });

  @override
  List<Object> get props => [batteryModel];
}

class BatterySucess extends BatteryState {
  final String message;

  const BatterySucess({required this.message});

  @override
  List<Object> get props => [message];
}

class BatteryError extends BatteryState {
  final String message;

  const BatteryError({required this.message});

  @override
  List<Object> get props => [message];
}
