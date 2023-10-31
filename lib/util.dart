const int dayZeroTimestampMillis =
    1696849200000; // 2023-10-09T04:00:00Z - my 28h week starts on Mondays at 04:00.
const int millisIn28hDay = 28 * 60 * 60 * 1000;

class Time {
  final int hours;
  final int minutes;
  final int seconds;
  final int millis;

  Time(this.hours, this.minutes, this.seconds, this.millis);
}

int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

Time timestampTo28h(int timestamp) {
  int diff = (timestamp - dayZeroTimestampMillis) % millisIn28hDay;
  if (diff < 0) {
    throw Exception("Haven't figured out how to get the time in the past yet");
  }
  int millis = diff % 1000;
  diff = diff ~/ 1000;
  int seconds = diff % 60;
  diff = diff ~/ 60;
  int minutes = diff % 60;
  diff = diff ~/ 60;
  int hours = diff;
  return Time(hours, minutes, seconds, millis);
}

String format28hString(Time time) {
  return '${time.hours.toString().padLeft(2, '0')}:${time.minutes.toString().padLeft(2, '0')}:${time.seconds.toString().padLeft(2, '0')}:${time.millis.toString().padLeft(3, '0')}';
}

String get28HourClockTime() {
  return format28hString(timestampTo28h(DateTime.now().millisecondsSinceEpoch));
}
