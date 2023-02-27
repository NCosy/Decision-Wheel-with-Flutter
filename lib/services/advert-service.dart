import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9375718730337475/1015191208";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9375718730337475/4543372677";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}