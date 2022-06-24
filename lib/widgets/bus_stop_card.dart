import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transito/models/app_colors.dart';

import '../models/bus_stops.dart';
import '../providers/search_provider.dart';
import '../screens/bus_timing_screen.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({Key? key, required this.busStopInfo, this.searchMode = false})
      : super(key: key);

  final BusStopInfo busStopInfo;
  final bool searchMode;

  void goToBusTimingScreen(BuildContext context, String busStopCode, String busStopName,
      String busStopAddress, LatLng busStopLocation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusTimingScreen(
          busStopCode: busStopCode,
          busStopName: busStopName,
          busStopAddress: busStopAddress,
          busStopLocation: busStopLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Material(
      color: Colors.transparent,
      child: Tooltip(
        preferBelow: false,
        showDuration: Duration(milliseconds: 350),
        message: busStopInfo.busStopName,
        child: InkWell(
          onTap: () {
            if (searchMode) {
              searchProvider.addRecentSearch(busStopInfo);
              debugPrint('Added recent search: ${busStopInfo.busStopName}');
            }
            goToBusTimingScreen(
              context,
              busStopInfo.busStopCode,
              busStopInfo.busStopName,
              busStopInfo.roadName,
              LatLng(busStopInfo.latitude, busStopInfo.longitude),
            );
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration:
                BoxDecoration(color: AppColors.cardBg, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  busStopInfo.busStopName,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: AppColors.veryPurple, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        busStopInfo.busStopCode,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        busStopInfo.roadName,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(color: AppColors.kindaGrey, fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
