import 'dart:io';

import 'package:dio/dio.dart';
import 'package:google_map_polyline_new/src/polyline_request.dart';
import 'package:google_map_polyline_new/src/route_mode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineUtils {
  PolylineRequestData? _data;
  PolylineUtils(this._data);

  Future<List<LatLng>?> getCoordinates() async {
    List<LatLng>? _coordinates = [];

    var qParam = {
      'mode': getMode(_data!.mode),
      'key': _data!.apiKey,
    };

    if (_data!.locationText!) {
      qParam['origin'] = _data!.originText;
      qParam['destination'] = _data!.destinationText;
    } else {
      qParam['origin'] =
          "${_data!.originLoc!.latitude},${_data!.originLoc!.longitude}";
      qParam['destination'] =
          "${_data!.destinationLoc!.latitude},${_data!.destinationLoc!.longitude}";
    }

    Response _response;
    Dio _dio = new Dio();
    Options? _options;

    if (Platform.isAndroid &&
        (_data!.xAndroidCert?.isNotEmpty ?? false) &&
        (_data!.xAndroidPackage?.isNotEmpty ?? false)) {
      _options = Options(headers: {
        'X-Android-Package': _data!.xAndroidPackage,
        'X-Android-Cert': _data!.xAndroidCert,
      });
    } else if (Platform.isIOS &&
        (_data!.xIosBundleIdentifier?.isNotEmpty ?? false)) {
      _options = Options(headers: {
        'X-Ios-Bundle-Identifier': _data!.xIosBundleIdentifier,
      });
    }

    _response = await _dio.get(
        "https://maps.googleapis.com/maps/api/directions/json",
        options: _options,
        queryParameters: qParam);

    try {
      if (_response.statusCode == 200) {
        if (_response.data["status"] == "REQUEST_DENIED") {
          throw Exception(_response.data["error_message"]);
        }

        _coordinates = decodeEncodedPolyline(
            _response.data['routes'][0]['overview_polyline']['points']);
      }
    } catch (e) {
      print('[ERROR_POLYLINE] ${e.toString()}');
    }

    return _coordinates;
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  String? getMode(RouteMode? _mode) {
    switch (_mode) {
      case RouteMode.driving:
        return 'driving';
      case RouteMode.walking:
        return 'walking';
      case RouteMode.bicycling:
        return 'bicycling';
      case RouteMode.transit:
        return 'transit';
      default:
        return null;
    }
  }
}
