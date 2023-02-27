import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "id";
    } else if (Platform.isIOS) {
      return "id";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
