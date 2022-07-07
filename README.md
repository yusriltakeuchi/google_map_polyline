
Gives polyline coordinates to set polylines in Google Map.

[![pub package](https://img.shields.io/pub/v/google_map_polyline.svg)](https://pub.dartlang.org/packages/google_map_polyline)

# google_map_polyline_new
Flutter plugin to retrieve coordinates (in latitude and longitude) to draw the polylines (Route) in `google_maps_flutter` package.
This package made with the inspiration of `flutter_polyline_points`.

This package is a continuation of the discontinued [google_map_polyline](https://pub.dev/packages/google_map_polyline)

### Getting Started

To use this plugin, add `google_map_polyline` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

1. First you need to create object using your **Google Maps API key**.
- Get an API key at [https://cloud.google.com/maps-platform/](https://cloud.google.com/maps-platform/).
	 (This plugin only requires **Directions API**.)

	```dart
		GoogleMapPolyline googleMapPolyline = 
			new  GoogleMapPolyline(apiKey:  "YOUR KEY HERE");
	```
		
2. Now you may able retrieve coordinates for the Polyline route.

- Get the Polyline coordinates using location coordinates (latitude and longitude)
	 ```dart
     	await googleMapPolyline.getCoordinatesWithLocation(
     		origin: LatLng(40.677939, -73.941755),
     		destination: LatLng(40.698432, -73.924038),
     		mode:  RouteMode.driving);	
	```


- Get the Polyline coordinates using address of the location
	```dart
		await googleMapPolyline.getPolylineCoordinatesWithAddress(
			origin:  '55 Kingston Ave, Brooklyn, NY 11213, USA',
			destination:  '8007 Cypress Ave, Glendale, NY 11385, USA',
			mode:  RouteMode.driving);
	```

### Overview
- [x] Coordinates with Location Coordinates (Latitude and Longitude)
- [x] Coordinates with Location Address
- [x] Route Modes
  	- [x] Driving
  	- [x] Walking
  	- [x] Bicycling
- [ ] Coordinates with Location Coordinates and Address (example: Origin as address and Destination as coordinates)
- [ ] Alternative routes

### Secured Google Map API Key
Added support for Google Map API Key when it's secured with the mobile application way.  
You can use the `package_info_plus` lib to retrieve `packageName` (applicationId) and `buildSignature` (sha1 sign of certificate)  
Then, you will be able to pass it in parameters like the ApiKey, and it will be added in the headers.

   ```dart
       PackageInfo packageInfo = await PackageInfo.fromPlatform();
       
       GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(
            apiKey: kGoogleMapApiKey,
            xAndroidCert: packageInfo.buildSignature,
            xAndroidPackage: packageInfo.packageName,
       );	
  ```
### Feature Requests and Issues
Please file feature requests and bugs at the  [issue tracker](https://github.com/Shark01/google_map_polyline/issues/new).
