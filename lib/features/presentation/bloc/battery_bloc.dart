import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givenergy_app/features/data/datasources/task_api.dart';

import '../../data/models/battery_model.dart';

part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  BatteryBloc() : super(BatteryInitial()) {
    on<GetBattery>((event, emit) => _getBattery(event, emit));
    on<SearchBatteryList>((event, emit) => _searchBattery(event, emit));
  }

  _getBattery(GetBattery event, emit) async {
    emit(BatteryLoading());
    await BatteryApiJsonCall.instance.getBatteries();
    emit(BatteryLoaded(batteryModel: BatteryApiJsonCall.instance.tasks, totalPower: BatteryApiJsonCall.instance.totalPower, averagePercentage: BatteryApiJsonCall.instance.averagePercentage));
  }

  _searchBattery(SearchBatteryList event, emit) async {
    emit(BatteryLoaded(
        batteryModel: BatteryApiJsonCall.instance.searchByName(event.title), totalPower: BatteryApiJsonCall.instance.totalPower, averagePercentage: BatteryApiJsonCall.instance.averagePercentage));
  }
}
