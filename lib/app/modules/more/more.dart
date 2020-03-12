import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class More extends StatefulWidget {
  _More createState() => _More();
}

class _More extends State<More> {
  String messageOfTheDay = '';
  String updateDate = '';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(), () async {
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      ref.child('messageOfTheDay').onValue.listen(
          (event) => setState(() => messageOfTheDay = event.snapshot.value));
      ref
          .child('updateDate')
          .onValue
          .listen((event) => setState(() => updateDate = event.snapshot.value));
    });
  }

  Widget cardMessageOfTheDay() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Mensagem do dia (requer internet)',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                Text(
                  messageOfTheDay,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Widget cardUpdateStatus() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Situação de atualização (requer internet)',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                Text(
                  updateDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Widget cardDevelopment() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Desenvolvimento',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://media-exp1.licdn.com/dms/image/C4E03AQGr09HaRe8PMw/profile-displayphoto-shrink_200_200/0?e=1588809600&v=beta&t=aJgqPqATXTJm7CU7I4SCOgzB6gSsT3FuExSOQOnpPdY')),
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    Text(
                      'Adrian Kohls',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).accentColor),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 2,
                  runSpacing: 2,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () =>
                          launch('https://linkedin.com/in/adriankohls/'),
                      child: Image.network(
                          'https://img.icons8.com/color/48/000000/linkedin.png'),
                    ),
                    FlatButton(
                      onPressed: () => launch('https://github.com/KohlsAdrian'),
                      child: Image.network(
                        'https://img.icons8.com/ios-filled/50/000000/github.png',
                        color: Colors.white,
                      ),
                    ),
                    FlatButton(
                      onPressed: () =>
                          launch('https://instagram.com/falakohls/'),
                      child: Image.network(
                          'https://img.icons8.com/color/48/000000/instagram-new.png'),
                    ),
                    FlatButton(
                      onPressed: () => launch('http://bus2.mobilibus.com'),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/Mw36nVkpNJMNmaJS9SAPbDiLhYK4l_ePL_lq1vxNueTp8q4W15E9wbpI1aepu3F-M6k=s180',
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget cardWhatsAppGroup() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Grupo do WhatsApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                FlatButton(
                  onPressed: () => launch(
                      'https://chat.whatsapp.com/JQILHVy6V0g7kBcGRyf7r3'),
                  child: Image.network(
                    'https://logodownload.org/wp-content/uploads/2015/04/whatsapp-logo-3-1.png',
                    height: 50,
                  ),
                ),
                Text(
                  'Clique na imagem',
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
  Widget cardUniVideoEsom() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Uni Video e Som LTDA',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Divider(color: Theme.of(context).accentColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () => launch(
                          'https://www.facebook.com/univideoinformatica/'),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://scontent.fbnu1-1.fna.fbcdn.net/v/t31.0-8/p960x960/22549063_1643196982418927_4069495094356721693_o.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=FikTlD7sBMYAX8AiAbM&_nc_ht=scontent.fbnu1-1.fna&_nc_tp=6&oh=d04b10fdfee79c0780866d600309956a&oe=5E90171A')),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '(47) 3387-2083',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Clique na imagem',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mais'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            cardDevelopment(),
            cardMessageOfTheDay(),
            cardUpdateStatus(),
            cardUniVideoEsom(),
            cardWhatsAppGroup(),
          ],
        ),
      ),
    );
  }
}
