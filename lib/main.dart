import 'dart:convert' as convert;
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volkmannbus/app/main_base.dart';
import 'package:volkmannbus/app/modules/price/base/Price.dart';
import 'package:volkmannbus/app/modules/timetable/base/Timetable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid)
    Admob.initialize('ca-app-pub-4712363316569389~4192829366');
  if (Platform.isIOS)
    Admob.initialize('ca-app-pub-4712363316569389~4616474964');
  runApp(MyApp());
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VolkmannBus',
      theme: ThemeData(
        primaryColor: Color(0xff063f1f),
        primaryColorDark: Color(0xff001b00),
        accentColor: Color(0xff81bb1b),
        primarySwatch: Colors.lime,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(),
      () async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        DatabaseReference ref = FirebaseDatabase.instance.reference();
        StorageReference sRef = FirebaseStorage.instance.ref();
        int updateInt = sp.getInt('updateInt') ?? -1;
        ref.child('updateInt').onValue.listen(
          (event) async {
            int newUpdateInt = event.snapshot.value;
            if (newUpdateInt > updateInt) {
              int twoMb = (1024 * 1024) * 2;
              await sRef
                  .child('timetable.json')
                  .getData(twoMb)
                  .then((value) async {
                String stringJson = convert.utf8.decode(value);
                sp.setString('timetable', stringJson);
              });
              await sRef.child('price.json').getData(twoMb).then((value) async {
                String stringJson = convert.utf8.decode(value);
                sp.setString('price', stringJson);
              });
              if (sp.containsKey('timetable') && sp.containsKey('price'))
                sp.setInt('updateInt', newUpdateInt);
            }
          },
        );

        Future.delayed(Duration(seconds: 5), () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          String jsonStringTimetable = sp.getString('timetable') ?? null;
          String jsonStringPrice = sp.getString('price') ?? null;
          Timetable timetable;
          List<Price> prices = [];
          if (jsonStringTimetable != null) {
            Map<String, dynamic> mapTimetable =
                convert.json.decode(jsonStringTimetable);
            timetable = Timetable.fromJson(mapTimetable);
          }

          if (jsonStringPrice != null) {
            Iterable iterablePrice = convert.json.decode(jsonStringPrice);
            prices = iterablePrice.map((e) => Price.fromJson(e)).toList();
          }

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MainBase(timetable, prices)));
        });
      },
    );
  }

  Future<void> fcmSetup(BuildContext context) async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) iOSPermission();

    _firebaseMessaging.configure(
      onLaunch: onLaunchMessageHandler,
      onMessage: onMessageMessageHandler,
      onResume: onResumeMessageHandler,
      onBackgroundMessage: isIOS ? null : onBackgroundMessageHandler,
    );
    String token = await _firebaseMessaging.getToken();
    try {
      print('fcm token: $token copied to clipboard');
    } on Exception {}

    await _firebaseMessaging.setAutoInitEnabled(true);
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/volkmann.png',
                height: 120,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text(
              'Um patrocínio:',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              child: Image.asset('assets/uni.jpg'),
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}

class AppOffline extends StatefulWidget {
  _AppOffline createState() => _AppOffline();
}

class _AppOffline extends State<AppOffline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Em manutenção'),
      ),
    );
  }
}

Future<dynamic> onBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print("onBackgroundMessageMessageHandler data: $data");
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    print("onBackgroundMessageMessageHandler notification: $notification");
  }
  return message;
}

Future<dynamic> onLaunchMessageHandler(var message) async {
  return message;
}

Future<dynamic> onMessageMessageHandler(var message) async {
  return message;
}

Future<dynamic> onResumeMessageHandler(var message) async {
  return message;
}
