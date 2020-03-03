class Relation {
  final int id;
  final int personId;
  final String personName;
  final String personDesc;
  final String personImg;
  final int recordId;
  final String recordTitle;
  final String recordDesc;
  final int recordKind;
  final String recordImg;
  final String relateWords;

  Relation(
      {this.id,
      this.personId,
      this.personName,
      this.personDesc,
      this.personImg,
      this.recordId,
      this.recordTitle,
      this.recordDesc,
      this.recordKind,
      this.recordImg,
      this.relateWords});

  Relation.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        personId = parsedJson['person_id'],
        personName = parsedJson['person_name'],
        personDesc = parsedJson['person_desc'],
        personImg = parsedJson['person_img'],
        recordId = parsedJson['record_id'],
        recordTitle = parsedJson['record_title'],
        recordDesc = parsedJson['record_desc'],
        recordKind = parsedJson['record_kind'],
        recordImg = parsedJson['record_img'] ?? '',
        relateWords = parsedJson['relate_words'];
}
