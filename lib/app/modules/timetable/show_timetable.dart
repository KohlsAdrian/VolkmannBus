import 'package:flutter/material.dart';
import 'package:volkmannbus/app/modules/timetable/base/Timetable.dart';

class ShowTimetable extends StatefulWidget {
  ShowTimetable(this.direction, this.directionName, {Key key})
      : super(key: key);
  final Direction direction;
  final String directionName;

  _ShowTimetable createState() => _ShowTimetable(direction, directionName);
}

class _ShowTimetable extends State<ShowTimetable>
    with TickerProviderStateMixin {
  _ShowTimetable(this.direction, this.directionName, {Key key}) : super();
  final Direction direction;
  final String directionName;

  List<Widget> tabViews = [];
  TabController tabController;

  Widget createListView(List<TimetableData> timetableData) {
    return ListView.builder(
      itemCount: timetableData.length,
      itemBuilder: (context, index) {
        TimetableData data = timetableData[index];
        String time = data.time;
        Service service = direction.services
            .firstWhere((element) => element.id == data.serviceId);
        String serviceDesc = service.service;

        return Container(
          color: index % 2 == 0 ? Color(0x3281bb1b) : Colors.white,
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              time,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(serviceDesc),
            isThreeLine: true,
            onTap: () {},
          ),
        );
      },
    );
  }

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    tabViews.add(createListView(direction.workingDays));
    tabViews.add(createListView(direction.saturdayDays));
    tabViews.add(createListView(direction.sundayholidayDays));
    super.initState();

    Future.delayed(Duration(seconds: 1), () async {
      DateTime now = DateTime.now();
      int weekDay = now.weekday;
      switch (weekDay) {
        case 7:
          tabController.index = 2;
          break;
        case 6:
          tabController.index = 1;
          break;
        default:
          tabController.index = 0;
          break;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(directionName),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(child: Text('Dias Úteis')),
            Tab(child: Text('Sábados')),
            Tab(child: Text('Domingo/Feriado')),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: TabBarView(
          children: tabViews,
          controller: tabController,
        ),
      ),
    );
  }
}
