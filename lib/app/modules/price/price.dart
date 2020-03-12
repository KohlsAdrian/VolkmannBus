import 'package:flutter/material.dart';
import 'package:volkmannbus/app/modules/price/base/Price.dart';

enum PRICETYPE {
  NORMAL,
  STUDENT,
  WORKER,
}

class PriceView extends StatefulWidget {
  PriceView(this.prices, {Key key}) : super(key: key);
  final List<Price> prices;
  _PriceView createState() => _PriceView(prices);
}

class _PriceView extends State<PriceView> with TickerProviderStateMixin {
  _PriceView(this.prices, {Key key}) : super();
  final List<Price> prices;

  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget pricesList(PRICETYPE pricetype) => ListView.builder(
        itemCount: prices.length,
        itemBuilder: (context, index) {
          Price price = prices[index];
          String directionName = price.directionName;
          String directionNameReverse = '';
          List<String> directionSplit = directionName.split(' / ');
          if (directionSplit.length > 1) {
            String name1 = directionSplit[0];
            String name2 = directionSplit[1];
            directionNameReverse = '$name2 / $name1';
          }
          double value = price.value;

          switch (pricetype) {
            case PRICETYPE.NORMAL:
              break;
            case PRICETYPE.STUDENT:
              value *= 50;
              value /= 2;
              break;
            case PRICETYPE.WORKER:
              value *= 50;
              break;
          }

          String valueStr = 'R\$ ${value.toStringAsFixed(2)}';
          return Container(
            color: index % 2 == 0 ? Color(0x3281bb1b) : Colors.white,
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                valueStr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text('$directionName\n$directionNameReverse'),
              onTap: () {},
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    List<Widget> tabViews = [
      pricesList(PRICETYPE.NORMAL),
      pricesList(PRICETYPE.STUDENT),
      pricesList(PRICETYPE.WORKER),
    ];

    List<Tab> tabs = PRICETYPE.values.map(
      (e) {
        String tabName = '';
        switch (e) {
          case PRICETYPE.NORMAL:
            tabName = 'Passagem normal';
            break;
          case PRICETYPE.STUDENT:
            tabName = 'Estudante Mensal';
            break;
          case PRICETYPE.WORKER:
            tabName = 'Trabalhador Mensal';
            break;
        }
        return Tab(
          child: Text(
            tabName,
            textAlign: TextAlign.center,
          ),
        );
      },
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Preços'),
        centerTitle: true,
      ),
      body: prices.length > 0
          ? Column(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    controller: tabController,
                    tabs: tabs,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 184,
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: TabBarView(
                      controller: tabController,
                      children: tabViews,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'Tabela de preço indisponível\n' +
                    'Verifique sua conexão com a internet e reinicie o aplicativo para atualizar os dados.',
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
