import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/poly_utils.dart';
import 'package:location/location.dart';

class RouteView extends StatefulWidget {
  _RouteView createState() => _RouteView();
}

class _RouteView extends State<RouteView> {
  Completer<GoogleMapController> googleMapController = Completer();

  Polyline polylinePomBnu;
  Polyline polylineBnuPom;

  bool showPomBnu = true;
  bool showBnuPom = false;
  bool showHeader = true;

  CameraPosition cameraPosition;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(), () async {
      Location location = Location();
      await location.requestPermission();
      List<Point<num>> pointsPomBnu = PolyUtils.decode(
          'jfraDtz|jH|NoCxHoBnKxCvJ}ElH`DfJwBdXzKzbA`@`w@xJr_Ahe@ppB~pA~r@zGdqAdf@~CdNvLfL|NpIb@rLbOa@tt@sJi@eJxi@wHvNkAhjAkXvZfJxgAcW~dByJnyC_N|rBdI~mAstAty@tWff@ekAj{AiDod@szAaBqq@cMs_@tFe_@sHoU}Dse@oHcc@OeEhMuQzFaFbL_Cr_AiXv@r@hF|KvEnGxAdDpAQlM_K`HiGnFwEdL}K`IqEdQmNzEU|LcC|@JrDdFdRfY`FHe@aCpKsI~F_TtL}YxYqYdTmg@x@_M`O}NhE`Bp@a@');
      List<Point<num>> pointsBnuPom = PolyUtils.decode(
          'v~icDbgljHcPg@cIrMtCrJqBj@oC|MsKxPyMrLgM~BcMrHuQpNeSxKaPnP_UeBmGI`@fF_E`DkGfF{FbEgFvG}ErHuJxKyEjFcKyLaJwPoHxDiF~DiV}UeLfJmHoCyCe@mB~BgD~EsAjE}EtDuFvFjBtBrBfBl@f@rBjEz@nCoCbDeCjDsCzDcAlDc@~AJp@j@|@t@rC?pBc@LQrFx@BdALZZPjAv@hD^xCl@nEZtCTdD\\hE\\xDr@xJ~@xFPr@Kb@Rf@`@DvBjFfAhD@~EoA|GyA`JkA~Cs@jBlElHzCdGlBjG~AnF`@jGKpEd@`]~BxNjDzQ|E~OvGtH~GzMjB~LqAdAkV_BsT{D}KlEwJjDiNTuHrH}IvYN~KmQhZyYzAcSgPgLyGiEJuLrJcOlJqEvJ}EjOuJrLeKxLaLjF_NhAsRwIcTmIgUyHkLaCcPbN_HfJiQxC_JuAyJlAmSdD{En@uFo@ySLuXcAkLvE_KyBuTtAoLlAgL|@k`@hFaJqAwFc@gXlEwW`EkJ~BsJlG_VaIyF_@iW`IyOzCkRfIeNAqA]_A@cAfAcMf@aJj@oFbAcC`@}AWiBQ_BR{A`AeC|AaBfA}@`@oCz@UFBfCD~DwCr@eEr@yGd@uFPcFXyEp@w@Ja@aJuBd@aDi@mCu@mCs@}Aa@mBcBiC_C{C}C_DgDaBaAaCiBM]Ku@SeEGgCsDu@wDcB}BgBqCoDgDqBgG_AeESkJUyHqAqK_CuGoJcC_AsICkM~@mDPaG_CcFuEsDoC_TgGkLcAsNuEyT{M_KiFsPa]uZsPiUwJkDeGiSiIuYaIe[SkWfHsMLsIiE}RiCiEiEmHiBmPB{IiC}IfFqJmDgF|BqGNyCn@yErA');

      polylinePomBnu = Polyline(
        width: 3,
        color: Theme.of(context).primaryColorDark,
        polylineId: PolylineId(pointsPomBnu.hashCode.toString()),
        points: pointsPomBnu.map((e) => LatLng(e.x, e.y)).toList(),
      );

      polylineBnuPom = Polyline(
        width: 3,
        color: Theme.of(context).accentColor,
        polylineId: PolylineId(pointsBnuPom.hashCode.toString()),
        points: pointsBnuPom.map((e) => LatLng(e.x, e.y)).toList(),
      );

      setState(() {});
    });
  }

  Widget header() => Container(
        padding: EdgeInsets.all(10),
        height: 160,
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Apresentar trajeto\nPomerode para Blumenau',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Switch(
                      value: showPomBnu,
                      onChanged: (value) => setState(() => showPomBnu = value)),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Apresentar trajeto\nBlumenau para Pomerode',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Switch(
                      value: showBnuPom,
                      onChanged: (value) => setState(() => showBnuPom = value)),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              ),
              Text(
                'Clique no mapa para esconder esse cabeçalho',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    List<Polyline> polylines = [];
    if (showPomBnu && polylinePomBnu != null) polylines.add(polylinePomBnu);
    if (showBnuPom && polylineBnuPom != null) polylines.add(polylineBnuPom);
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerário'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (_) => setState(() => showHeader = !showHeader),
            cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              northeast: LatLng(-26.659608, -48.910622),
              southwest: LatLng(-26.974525, -49.242593),
            )),
            compassEnabled: true,
            indoorViewEnabled: true,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              googleMapController.complete(controller);
              Future.delayed(Duration(seconds: 3), () async {
                LocationData locationData = await Location().getLocation();
                LatLng latLng =
                    LatLng(locationData.latitude, locationData.longitude);
                controller.animateCamera(CameraUpdate.newLatLng(latLng));
              });
            },
            onCameraMove: (cameraPosition) =>
                this.cameraPosition = cameraPosition,
            buildingsEnabled: true,
            polylines: Set<Polyline>.of(polylines),
            minMaxZoomPreference: MinMaxZoomPreference(10, 20),
            initialCameraPosition: CameraPosition(
              zoom: 10,
              target: LatLng(-26.737234, -49.178616),
            ),
          ),
          showHeader ? header() : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => googleMapController.future.then((value) async {
          LocationData location = await Location().getLocation();
          value.animateCamera(CameraUpdate.newLatLng(
              LatLng(location.latitude, location.longitude)));
        }),
        child: Icon(Icons.my_location),
      ),
    );
  }
}
