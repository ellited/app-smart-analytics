import 'package:intl/intl.dart';



class DateUtils {
    String currentMonthName() {
        var now = new DateTime.now();
        var formatter = new DateFormat('MMMM');
        return formatter.format(now);
    }
}
