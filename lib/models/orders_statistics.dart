class OrdersStatistics {
  final int overallOrdersCountToday;
  final double revenueThisMonth;
  final double overallRevenue;
  final int ordersCountThisMonth;
  final int overallOrdersCount;
  final int ordersCountPreviousMonth;

  OrdersStatistics(
      {this.overallOrdersCountToday,
        this.revenueThisMonth,
        this.overallRevenue,
        this.ordersCountThisMonth,
        this.overallOrdersCount,
        this.ordersCountPreviousMonth});

  factory OrdersStatistics.fromJson(Map<String, dynamic> json) {
    return OrdersStatistics(
      overallOrdersCountToday: json['stats'][0]['overall_orders_count_today'],
      revenueThisMonth: json['stats'][0]['overall_revenue_last_months'][0],
      overallRevenue: json['stats'][0]['overall_revenue'],
      ordersCountThisMonth: json['stats'][0]['overall_orders_count_last_months']
      [0],
      overallOrdersCount: json['stats'][0]['overall_orders_count'],
      ordersCountPreviousMonth: json['stats'][0]
      ['overall_orders_count_last_months'][1],
    );
  }
}
