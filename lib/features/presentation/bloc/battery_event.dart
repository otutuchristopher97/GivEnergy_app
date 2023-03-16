part of 'battery_bloc.dart';

abstract class BatteryEvent extends Equatable {
  const BatteryEvent();

  @override
  List<Object> get props => [];
}

class GetBattery extends BatteryEvent {
  const GetBattery();

  @override
  List<Object> get props => [];
}

class SearchBatteryList extends BatteryEvent {
  final String title;

  const SearchBatteryList({required this.title});
  @override
  List<Object> get props => [title];
}
