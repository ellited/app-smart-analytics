import 'dart:async';
import 'package:app_smart_analytics/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'models/orders_statistics.dart';
import 'requests/get_orders_request.dart';
import 'utils/number_utils.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<OrdersStatistics> futureOrdersStatistics;

  @override
  void initState() {
    super.initState();
    futureOrdersStatistics = fetchOrdersStats();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders Analytics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Orders Analytics'),
        ),
        body: Material(
          child: FutureBuilder<OrdersStatistics>(
            future: futureOrdersStatistics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                        'Orders today: ${NumberUtils().numberFormatterRound.format(snapshot.data.overallOrdersCountToday)}'),
                    Text(
                        'Revenue for ${DateUtils().currentMonthName()}: ${NumberUtils().numberFormatter.format(snapshot.data.revenueThisMonth)} €'),
                    Text('Overal revenue: ${NumberUtils().numberFormatter.format(snapshot.data.overallRevenue)} €'),
                    Text(
                        'Orders count this month: ${NumberUtils().numberFormatterRound.format(snapshot.data.ordersCountThisMonth)}'),
                    Text(
                        'Overal orders count: ${NumberUtils().numberFormatterRound.format(snapshot.data.overallOrdersCount)}'),
                    Text(
                        'Orders count previous month: ${NumberUtils().numberFormatterRound.format(snapshot.data.ordersCountPreviousMonth)}'),
                    Text(
                        'Orders count percentage compare with previous month: ${snapshot.data.ordersCountThisMonth / snapshot.data.ordersCountPreviousMonth * 100 - 100}'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
