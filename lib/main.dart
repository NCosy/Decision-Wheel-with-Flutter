import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'services/advert-service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final StreamController _dividerController = StreamController<int>();

  @override
  dispose() {
    _dividerController.close();
    _ad?.dispose();
    super.dispose();
  }
  BannerAd _ad;
  bool isLoaded;

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.largeBanner,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (_,error) {
          print("Ad Failed to Load with Error : $error");
        }
      ),

    );

    _ad.load();
  }


  Widget checkForAd() {
      return Container(
        child: AdWidget(
          ad: _ad,
        ),
        width: 320,
        height: 100,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 25),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          elevation: 0.0,
          title: Text(
            'Karar Çarkı',
            style: TextStyle(
              color: Colors.tealAccent[700],
              fontSize: 30,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.blueGrey[800],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinningWheel(
                Image.asset('images/yesno.png'),
                width: 310,
                height: 310,
                initialSpinAngle: _generateRandomAngle(),
                spinResistance: 0.2,
                dividers: 6,
                onUpdate: _dividerController.add,
                onEnd: _dividerController.add,
              ),
              StreamBuilder(
                stream: _dividerController.stream,
                builder: (context, snapshot) =>
                    snapshot.hasData ? SpinData(snapshot.data) : Container(),
              ),
              checkForAd()
            ],
          ),
        ),
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class SpinData extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: 'Evet',
    2: 'Hayır',
    3: 'Evet',
    4: 'Hayır',
    5: 'Evet',
    6: 'Hayır',
  };

  SpinData(this.selected);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.keyboard_arrow_up,
          color: Colors.tealAccent[700],
          size: 60,
        ),
        Text(
          '${labels[selected]}',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.tealAccent[700],
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
