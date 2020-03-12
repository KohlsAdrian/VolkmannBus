class Timetable {
  final Direction pomBnu;
  final Direction bnuPom;

  Timetable(this.pomBnu, this.bnuPom);

  factory Timetable.fromJson(Map<String, dynamic> json) {
    Direction pomBnu = json.containsKey('pombnu')
        ? Direction.fromJson(json['pombnu'] as Map)
        : {};
    Direction bnuPom = json.containsKey('bnupom')
        ? Direction.fromJson(json['bnupom'] as Map)
        : {};
    return Timetable(pomBnu, bnuPom);
  }
}

class Direction {
  final List<Service> services;
  final List<TimetableData> workingDays;
  final List<TimetableData> saturdayDays;
  final List<TimetableData> sundayholidayDays;

  Direction(this.services, this.workingDays, this.saturdayDays,
      this.sundayholidayDays);

  factory Direction.fromJson(Map<String, dynamic> json) {
    List<Service> services = (json['services'] as Iterable)
            .map((e) => Service.fromJson(e))
            .toList() ??
        [];

    List<TimetableData> workingDays = (json['workingdays'] as Iterable)
            .map((e) => TimetableData.fromJson(e))
            .toList() ??
        [];
    List<TimetableData> saturdayDays = (json['saturday'] as Iterable)
            .map((e) => TimetableData.fromJson(e))
            .toList() ??
        [];
    List<TimetableData> sundayholidayDays = (json['sundayholiday'] as Iterable)
            .map((e) => TimetableData.fromJson(e))
            .toList() ??
        [];

    return Direction(
        services, workingDays, saturdayDays, sundayholidayDays);
  }
}

class Service {
  final int id;
  final String service;

  Service(this.id, this.service);

  factory Service.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    String service = json['service'] ?? '';
    return Service(id, service);
  }
}

class TimetableData {
  final String time;
  final int serviceId;

  TimetableData(this.time, this.serviceId);

  factory TimetableData.fromJson(Map<String, dynamic> json) {
    String time = json['time'] ?? '';
    int serviceId = json['serviceId'] ?? 0;
    return TimetableData(time, serviceId);
  }
}
