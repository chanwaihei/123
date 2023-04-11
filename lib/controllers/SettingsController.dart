import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';


class SettingsController extends GetxController {
  // 定义 lunchStartTime、lunchEndTime、dinnerStartTime 和 dinnerEndTime 变量并分配默认值
  //Rx<TimeOfDay> lunchStartTime = (TimeOfDay(hour: 12, minute: 0)).obs;
  //Rx<TimeOfDay> lunchEndTime = (TimeOfDay(hour: 15, minute: 0)).obs;
 // Rx<TimeOfDay> dinnerStartTime = (TimeOfDay(hour: 18, minute: 0)).obs;
 // Rx<TimeOfDay> dinnerEndTime = (TimeOfDay(hour: 20, minute: 0)).obs;
  Rx<TimeOfDay> lunchStartTime = Rx<TimeOfDay>(TimeOfDay(hour: 12, minute: 0));
  Rx<TimeOfDay> lunchEndTime = Rx<TimeOfDay>(TimeOfDay(hour: 15, minute: 0));
  Rx<TimeOfDay> dinnerStartTime = Rx<TimeOfDay>(TimeOfDay(hour: 18, minute: 0));
  Rx<TimeOfDay> dinnerEndTime = Rx<TimeOfDay>(TimeOfDay(hour: 20, minute: 0));

  @override
  void onInit() {
    super.onInit();
    // 加载存储的设置值
    _loadSettings();
  }

  // 更新 lunchStartTime
  void updateLunchStartTime(TimeOfDay newTime) {
    lunchStartTime.value = newTime;
    _saveSettings();
  }

  // 更新 lunchEndTime
  void updateLunchEndTime(TimeOfDay newTime) {
    lunchEndTime.value = newTime;
    _saveSettings();
  }

  // 更新 dinnerStartTime
  void updateDinnerStartTime(TimeOfDay newTime) {
    dinnerStartTime.value = newTime;
    _saveSettings();
  }

  // 更新 dinnerEndTime
  void updateDinnerEndTime(TimeOfDay newTime) {
    dinnerEndTime.value = newTime;
    _saveSettings();
  }

  void _loadSettings() {
    final storage = GetStorage();
    lunchStartTime.value = _timeFromString(storage.read("lunchStartTime") ?? "12:00 PM");
    lunchEndTime.value = _timeFromString(storage.read("lunchEndTime") ?? "2:00 PM");
    dinnerStartTime.value = _timeFromString(storage.read("dinnerStartTime") ?? "6:00 PM");
    dinnerEndTime.value = _timeFromString(storage.read("dinnerEndTime") ?? "8:00 PM");
  }

  void _saveSettings() {
    final storage = GetStorage();
    storage.write("lunchStartTime", _stringFromTime(lunchStartTime.value));
    storage.write("lunchEndTime", _stringFromTime(lunchEndTime.value));
    storage.write("dinnerStartTime", _stringFromTime(dinnerStartTime.value));
    storage.write("dinnerEndTime", _stringFromTime(dinnerEndTime.value));
  }

  TimeOfDay _timeFromString(String timeString) {
    final format = DateFormat.jm(); // Use the correct format for your time string
    final dateTime = format.parse(timeString);
    return TimeOfDay.fromDateTime(dateTime);
  }

  String _stringFromTime(TimeOfDay time) {
    final parsedString = DateFormat("h:mm a").format(DateTime(0, 0, 0, time.hour, time.minute));
    return parsedString;
  }
}
