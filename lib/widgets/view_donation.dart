import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'payment_bottom_sheet.dart';

class ViewDonation extends StatefulWidget {
  final String name;
  final String amt;
  const ViewDonation({
    super.key,
    required this.name,
    required this.amt,
  });

  @override
  State<ViewDonation> createState() => _ViewDonationState();
}

class _ViewDonationState extends State<ViewDonation> {
  bool expandMore = false;
  // bool displayText = false;
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(
        'Donation',
        50,
        Colors.green,
      ),
    ];

    return Column(
      children: [
        Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: expandMore
                ? MediaQuery.of(context).size.height * 0.25
                : MediaQuery.of(context).size.height * 0.09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RadialChart(chartData: chartData),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.007,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.001,
                          ),
                          Text(
                            'Rs. ${widget.amt}',
                            style: const TextStyle(
                              color: Color(0xff4A4949),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            expandMore = !expandMore;
                          });
                        },
                        child: Icon(
                          expandMore
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: expandMore,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.003,
                      left: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: const Text('Reason will be listed here'),
                  ),
                ),
                if (expandMore)
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.007,
                      left: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: const Text('Numbers of Donors : ___'),
                  ),
                if (expandMore) const Spacer(),
                if (expandMore)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.16,
                        height: MediaQuery.of(context).size.height * 0.04,
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              enableDrag: true,
                              context: context,
                              builder: (context) {
                                return const AmountBottomSheet();
                              },
                            );
                          },
                          child: const FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'PAY',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RadialChart extends StatelessWidget {
  const RadialChart({
    super.key,
    required this.chartData,
  });

  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfCircularChart(
          series: <CircularSeries>[
            RadialBarSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData donation, _) => donation.x,
              yValueMapper: (ChartData donation, _) => donation.y,
              pointColorMapper: (ChartData data, _) => data.useColor,
              maximumValue: 100,
              innerRadius: '80%',
              radius: '100%',
              cornerStyle: CornerStyle.endCurve,
            ),
          ],
        ),
        const Center(
          child: Text('50%'),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.useColor);
  final String x;
  final int y;
  final Color useColor;
}
