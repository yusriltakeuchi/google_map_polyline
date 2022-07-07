import 'package:google_map_polyline_new/src/polyline_request.dart';
import 'package:google_map_polyline_new/src/polyline_utils.dart';
import 'package:google_map_polyline_new/src/route_mode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Gives polyline coordinates to set polylines in Google Map.
class GoogleMapPolyline {
  String apiKey;
  String? xAndroidPackage;
  String? xAndroidCert;
  String? xIosBundleIdentifier;

  GoogleMapPolyline({
    required this.apiKey,
    this.xAndroidPackage,
    this.xAndroidCert,
    this.xIosBundleIdentifier,
  });

  late PolylineUtils _utils;
  PolylineRequestData? _data;

  /// Get coordinates using Location Coordinates
  /// Example : LatLng(40.677939, -73.941755)
  Future<List<LatLng>?> getCoordinatesWithLocation({
    required LatLng origin,
    required LatLng destination,
    required RouteMode mode,
  }) async {
    _data = new PolylineRequestData(
      originLoc: origin,
      destinationLoc: destination,
      mode: mode,
      locationText: false,
      apiKey: apiKey,
      xAndroidPackage: xAndroidPackage,
      xAndroidCert: xAndroidCert,
      xIosBundleIdentifier: xIosBundleIdentifier,
    );

    _utils = new PolylineUtils(_data);

    return await _utils.getCoordinates();
  }

  /// Get coordinates using Location Coordinates
  /// Example : '55 Kingston Ave, Brooklyn, NY 11213, USA'
  Future<List<LatLng>?> getPolylineCoordinatesWithAddress({
    required String origin,
    required String destination,
    required RouteMode mode,
  }) async {
    _data = new PolylineRequestData(
      originText: origin,
      destinationText: destination,
      mode: mode,
      locationText: true,
      apiKey: apiKey,
      xAndroidPackage: xAndroidPackage,
      xAndroidCert: xAndroidCert,
      xIosBundleIdentifier: xIosBundleIdentifier,
    );

    _utils = new PolylineUtils(_data);

    return await _utils.getCoordinates();
  }
}
