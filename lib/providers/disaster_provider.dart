import 'package:flutter/cupertino.dart';

import '/models/current_disaster.dart';
import '../config/colors.dart';

class CurrentDisasterProvider with ChangeNotifier {
  int cardIndex = 0;
  final List<CurrentDisaster> _disasterList = [
    CurrentDisaster(
      cardColor: AppColor.brown,
      iconColor: AppColor.iconBrown,
      disasterPic: 'assets/images/earthquake.png',
      iconLocation: 'assets/images/earthquake_icon.png',
      disasterName: 'Earthquake',
      location: 'City,State',
      source: 'NGO',
      dateTime: DateTime(2023, 01, 17),
    ),
    CurrentDisaster(
      cardColor: AppColor.blue,
      iconColor: AppColor.iconBlue,
      disasterPic: 'assets/images/tsunami.png',
      iconLocation: 'assets/images/tsunami_icon.png',
      disasterName: 'Tsunami',
      location: 'City,State',
      source: 'NGO',
      dateTime: DateTime(2023, 01, 07),
    ),
    CurrentDisaster(
      cardColor: AppColor.yellow,
      iconColor: AppColor.iconYellow,
      disasterPic: 'assets/images/forestfire_image.jpg',
      iconLocation: 'assets/images/forestfire_icon.png',
      disasterName: 'Wildfire',
      location: 'City,State',
      source: 'NGO',
      dateTime: DateTime(2023, 01, 05),
    ),
    CurrentDisaster(
      cardColor: AppColor.blue,
      iconColor: AppColor.iconBlue,
      disasterPic: 'assets/images/cyclone_image.jpg',
      iconLocation: 'assets/images/cyclone_icon.png',
      disasterName: 'Cyclone',
      location: 'City,State',
      source: 'NGO',
      dateTime: DateTime(2022, 12, 31),
    ),
    CurrentDisaster(
      cardColor: AppColor.blue,
      iconColor: AppColor.iconBlue,
      disasterPic: 'assets/images/flood_image.jpg',
      iconLocation: 'assets/images/flood_icon.png',
      disasterName: 'Flood',
      location: 'City,State',
      source: 'NGO',
      dateTime: DateTime(2022, 12, 26),
    ),
    CurrentDisaster(
      cardColor: AppColor.brown,
      iconColor: AppColor.iconBrown,
      disasterPic: 'assets/images/landslide_image.jpg',
      iconLocation: 'assets/images/landslide_icon.png',
      disasterName: 'Landslide',
      location: 'City,State',
      source: 'NGO',
      dateTime: DateTime(2022, 12, 20),
    ),
  ];

  List<CurrentDisaster> get disasterList {
    return [..._disasterList];
  }

  void changeCarousel(int index) {
    cardIndex = index;
    notifyListeners();
  }
}