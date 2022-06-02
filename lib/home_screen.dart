import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'otherone.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BannerAd _bannerAd;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initiateBannerAd();
  }

  _initiateBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: BannerAd.testAdUnitId,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _isLoading = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        print('$error ///////////////////////////////////////////////////////');
      }),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ad test'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OtherOne()));
            },
            child: Text('go forward')),
      ),
      bottomNavigationBar: _isLoading
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: _bannerAd,
              ),
            )
          : Container(
              height: 50,
              color: Colors.red,
              child: const Center(
                child: Text('failed'),
              ),
            ),
    );
  }
}
