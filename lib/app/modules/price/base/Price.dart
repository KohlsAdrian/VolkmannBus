class Price {
  final String directionName;
  final double value;

  Price(this.directionName, this.value);

  factory Price.fromJson(Map<String, dynamic> json) {
    String directionName = json['directionName'] ?? '';
    double value = json['value'] ?? 0.0;
    return Price(directionName, value);
  }
}
