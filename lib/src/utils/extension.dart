import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  /// Returns [DateTime] without timestamp - VERSIÓN SEGURA
  DateTime get withoutTime => DateTime(year, month, day);

  // Returns total minutes this date is pointing at.
  /// if [DateTime] object is, DateTime(2021, 5, 13, 12, 4, 5)
  /// Then this getter will return 12*60 + 4 which evaluates to 724.
  int get totalMinutes => hour * 60 + minute;

  int getDayDifference(DateTime date) => withoutTime.difference(date.withoutTime).inDays;
  
  /// Calcula la diferencia de días de forma segura para cualquier zona horaria
  int getDayDifferenceUTC(DateTime date) => _safeDayDifference(this, date);
  
  /// Método auxiliar para calcular diferencias de días de forma segura
  static int _safeDayDifference(DateTime date1, DateTime date2) {
    // Normalizar ambas fechas a UTC a medianoche
    final utc1 = DateTime.utc(date1.year, date1.month, date1.day);
    final utc2 = DateTime.utc(date2.year, date2.month, date2.day);
    
    // Calcular la diferencia
    final difference = utc1.difference(utc2).inDays;
    
    return difference;
  }

  /// get startOfWeek day depending on the desired starting day of the week
  DateTime startOfWeek(int weekday) {
    var dayDifference = (this.weekday - weekday) % 7;
    return DateTime(year, month, day - dayDifference);
  }
}

extension TimerOfDayExtension on TimeOfDay {
  int get totalMinutes => hour * 60 + minute;
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension BuildContextExtension on BuildContext {
  bool get isDarkMode =>
      Theme.of(this).colorScheme.surface.computeLuminance() < 0.128;
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? getOrNull(int index) {
    if (index >= length || index < 0) return null;
    return elementAt(index);
  }
}
