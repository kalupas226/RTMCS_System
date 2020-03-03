import 'package:flutter/foundation.dart';
import 'relation.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RelationData with ChangeNotifier {
  List<Relation> _relations = [];

  UnmodifiableListView<Relation> get relations {
    return UnmodifiableListView(_relations);
  }

  Future<void> fetchRelations(int id, int kind) async {
    removeRelations();

    String url = 'http://localhost:5000/relations';
    var response = await http.post(url, body: {
      'id': id.toString(),
      'kind': kind.toString(),
    });
    if (response.statusCode == 200) {
      print('success');
      final relationsRawJson = utf8.decode(response.bodyBytes);
      final relationsJson = json.decode(relationsRawJson);
      for (var relationJson in relationsJson) {
        Relation relation = Relation.fromJson(relationJson);
        addRelation(relation);
      }
    } else {
      print('failed');
      throw Exception('Failed to fetch Relations');
    }
  }

  void addRelation(Relation relation) {
    _relations.add(relation);
    notifyListeners();
  }

  void removeRelations() {
    _relations.clear();
    notifyListeners();
  }
}
