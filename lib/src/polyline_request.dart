import 'package:google_map_polyline_new/src/route_mode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineRequestData {
  LatLng? originLoc;
  LatLng? destinationLoc;
  String? originText;
  String? destinationText;
  RouteMode? mode;
  bool? locationText;
  String? apiKey;
  String? xAndroidPackage;
  String? xAndroidCert;
  String? xIosBundleIdentifier;

  PolylineRequestData({
    this.originLoc,
    this.destinationLoc,
    this.originText,
    this.destinationText,
    this.mode,
    this.locationText,
    this.apiKey,
    this.xAndroidPackage,
    this.xAndroidCert,
    this.xIosBundleIdentifier,
  });
}
