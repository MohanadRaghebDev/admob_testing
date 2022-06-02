import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class OtherOne extends StatelessWidget {
  OtherOne({Key? key}) : super(key: key) {
    initAd();
  }

  late InterstitialAd _interstitialAd;
  bool _isLoading = false;

  void initAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {
          print(
              '$error ////////////////////////////////////////////////////////////////');
        },
      ),
    );
  }

  void onAdLoaded(InterstitialAd ad) {
    print('loaded ///////////////////////');
    _interstitialAd = ad;
    _isLoading = true;
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
              if (_isLoading) {
                _interstitialAd.show();
                Navigator.of(context).pop();
              }
            },
            child: Text('go back')),
      ),
    );
  }
}
