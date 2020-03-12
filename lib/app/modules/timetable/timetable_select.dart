import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:volkmannbus/app/modules/timetable/base/Timetable.dart';

import 'show_timetable.dart';

class TimetableSelect extends StatefulWidget {
  TimetableSelect(this.timetable, {Key key}) : super(key: key);
  final Timetable timetable;
  _TimetableSelect createState() => _TimetableSelect(timetable);
}

class _TimetableSelect extends State<TimetableSelect> {
  _TimetableSelect(this.timetable, {Key key}) : super();
  final Timetable timetable;
  AdmobBanner admob = AdmobBanner(
    adUnitId: Platform.isAndroid
        ? 'ca-app-pub-4712363316569389/9580887418'
        : Platform.isIOS ? 'ca-app-pub-4712363316569389/6152917912' : '',
    adSize: AdmobBannerSize.SMART_BANNER,
  );
  Widget cardPomBnu() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pomerode a Blumenau',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                Text(
                  'Saída da Rega II',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Widget cardBnuPom() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Blumenau a Pomerode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                Text(
                  'Saída do Terminal da Fonte',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void dialogNoTimetable() => showDialog(
        context: context,
        child: AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Tabela de Horários indisponível',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Text(
            'Verifique sua conexão com a internet e reinicie o aplicativo para atualizar os dados.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Entendido'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horários'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => timetable != null
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShowTimetable(
                        timetable.pomBnu, 'Pomerode para Blumenau')))
                : dialogNoTimetable(),
            child: cardPomBnu(),
          ),
          InkWell(
            onTap: () => timetable != null
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShowTimetable(
                        timetable.bnuPom, 'Blumenau para Pomerode')))
                : dialogNoTimetable(),
            child: cardBnuPom(),
          ),
          Container(
            height: 150,
            child: admob,
          ),
        ],
      ),
    );
  }
}
