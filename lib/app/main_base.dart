import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volkmannbus/app/modules/more/more.dart';
import 'package:volkmannbus/app/modules/price/base/Price.dart';
import 'package:volkmannbus/app/modules/price/price.dart';
import 'package:volkmannbus/app/modules/route/route.dart';
import 'package:volkmannbus/app/modules/timetable/base/Timetable.dart';
import 'package:volkmannbus/app/modules/timetable/timetable_select.dart';
import 'package:volkmannbus/main.dart';

class MainBase extends StatefulWidget {
  MainBase(this.timetable, this.prices, {Key key}) : super(key: key);
  final Timetable timetable;
  final List<Price> prices;
  _MainBase createState() => _MainBase(timetable, prices);
}

class _MainBase extends State<MainBase> {
  _MainBase(this.timetable, this.prices, {Key key}) : super();
  final Timetable timetable;
  final List<Price> prices;

  int selectedBottomBarItem = 0;

  void selectBottomBarItem(int index) =>
      setState(() => selectedBottomBarItem = index);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(), () async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      bool operable = sp.getBool('operable') ?? true;
      ref.child('operable').onValue.listen((event) {
        operable = event.snapshot.value;
        sp.setBool('operable', operable);
        if (!operable)
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AppOffline()));
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomBarViews = [
      TimetableSelect(timetable),
      PriceView(prices),
      RouteView(),
      More(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedBottomBarItem,
        children: bottomBarViews,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedBottomBarItem,
        fixedColor: Theme.of(context).accentColor,
        onTap: selectBottomBarItem,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.access_time),
            title: Text('Horários'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.attach_money),
            title: Text('Preços'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.directions),
            title: Text('Itinerário'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.menu),
            title: Text('Mais'),
          ),
        ],
      ),
    );
  }
}
