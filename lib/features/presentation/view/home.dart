import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givenergy_app/features/data/models/battery_model.dart';
import 'package:intl/intl.dart';
import 'widget/showbottomsheet.dart';

import '../bloc/battery_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BatteryBloc batteryBloc = BatteryBloc();
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    batteryBloc.add(const GetBattery());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    batteryBloc.close();
    // videoController.dispose();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Confirm Exit",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Are you sure you want to exit the App?",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              GestureDetector(
                child: const Text(
                  "NO",
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  return Navigator.of(context).pop(false);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 2, backgroundColor: const Color(0xff4CC0AB)),
                child: const Text("YES"),
                onPressed: () {
                  return Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BatteryBloc>(
      create: (context) {
        return batteryBloc;
      },
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 170,
                decoration: const BoxDecoration(
                    color: Color(0xff4CC0AB),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Giv',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Energy',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // navigate to desired screen
                                      })
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SearchField(
                      controller: controller!,
                    )
                  ]),
                ),
              ),
              Expanded(
                child: BlocConsumer<BatteryBloc, BatteryState>(
                  listener: (context, state) {
                    if (state is BatteryError) {}
                    if (state is BatteryLoaded) {}
                  },
                  builder: (context, state) {
                    if (state is BatteryLoading) {
                      return _buildLoading();
                    } else if (state is BatteryLoaded) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.batteryModel.length,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: GivEnergyItem(const Key(""),
                                          state.batteryModel[index]),
                                    )),
                          ),
                          Container(
                            height: 70,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 73, 152, 139),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Power :  ${state.totalPower.toStringAsFixed(2)}W",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Averatage (%) :  ${state.averagePercentage.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) => Container());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

class GivEnergyItem extends StatelessWidget {
  final BatteryModel? batteryModel;
  GivEnergyItem(Key? key, this.batteryModel) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              ShareButtomSheetView(batteryModel: batteryModel),
        ),
        child: Card(
          elevation: 0.5,
          shadowColor: Colors.green[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Battery ${batteryModel!.serial.toString()}',
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
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
                height: 10,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: const Color(0xfff8f8f8),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintText: 'Search by Battery Serial or Status',
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffbdbdbd),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (value) {
          context
              .read<BatteryBloc>()
              .add(SearchBatteryList(title: widget.controller.text));
          setState(() {});
        });
  }
}
