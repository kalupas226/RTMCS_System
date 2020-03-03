import 'package:flutter/foundation.dart';
import './record.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecordData extends ChangeNotifier {
  Record _record;
  List<Record> _records = [];
  bool isShishiChecked = false;
  bool isJinbutsuChecked = false;
  bool isWebmapChecked = false;
  bool isDigitalChecked = false;

  Record get record => _record;

  UnmodifiableListView<Record> get records {
    return UnmodifiableListView(_records);
  }

  Future<List<Record>> fetchRecords(String searchText) async {
    removeRecord();
    String url = 'http://localhost:5000/records';
    var response = await http.post(url, body: {
      'keyword': searchText,
      'jinbutsu': isJinbutsuChecked.toString(),
      "shishi": isShishiChecked.toString(),
      "webmap": isWebmapChecked.toString(),
      "digital": isDigitalChecked.toString()
    });

    if (response.statusCode == 200) {
      final recordsRawJson = utf8.decode(response.bodyBytes);
      final recordsJson = json.decode(recordsRawJson);
      for (var recordJson in recordsJson) {
        Record record = Record.fromJson(recordJson);
        addRecord(record);
      }
      notifyListeners();
      return _records;
    } else {
      print('failed');
      throw Exception('Failed to fetch Records');
    }
  }

  void addRecord(Record record) {
    _records.add(record);
    notifyListeners();
  }

  void removeRecord() {
    _records.clear();
    notifyListeners();
  }

  void createRecord(int index) {
    _record = _records[index];
    notifyListeners();
  }

  // bad naming
  void newRecord(Record record) {
    _record = record;
    notifyListeners();
  }

  void changeJinbutsuCheck() {
    isJinbutsuChecked = !isJinbutsuChecked;
    notifyListeners();
  }

  void changeShishiCheck() {
    isShishiChecked = !isShishiChecked;
    notifyListeners();
  }

  void changeWebmapCheck() {
    isWebmapChecked = !isWebmapChecked;
    notifyListeners();
  }

  void changeDigitalCheck() {
    isDigitalChecked = !isDigitalChecked;
    notifyListeners();
  }
}
