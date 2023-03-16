import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givenergy_app/features/data/datasources/task_provider.dart';
import 'package:givenergy_app/features/presentation/bloc/battery_bloc.dart';
import 'package:givenergy_app/features/presentation/view/home.dart';
import 'package:provider/provider.dart';

import 'core/constant.dart';
import 'features/presentation/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BatteryBloc>(
      create: (context) => BatteryBloc(),
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => BatteryProvider(),
            ),
          ],
          child: Consumer<BatteryProvider>(builder: (ctx, auth, _) {
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: SplashScreen(),
                routes: {
                  kHomeScreen: (ctx) => HomeScreen(),
                },
                );
          })),
    );
  }
}
