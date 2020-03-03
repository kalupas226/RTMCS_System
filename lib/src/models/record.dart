class Record {
  final int id;
  final String title;
  final String description;
  final String imgUrl;
  final int kind;

  Record({this.id, this.title, this.description, this.imgUrl, this.kind});

  Record.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'].replaceAll('\n', ''),
        description = parsedJson['description'].replaceAll('\n', ''),
        imgUrl = parsedJson['img'] ?? '',
        kind = parsedJson['kind'];
}
