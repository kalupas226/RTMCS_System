import 'package:flutter/material.dart';
import '../models/relation_data.dart';
import '../models/relation.dart';
import '../models/record_data.dart';
import '../models/record.dart';
import 'package:provider/provider.dart';

class RecordDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordData>(
      builder: (context, recordData, child) {
        return Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: recordData.record.imgUrl != ''
                        ? Image.network(recordData.record.imgUrl, cacheHeight: 400,)
                        : const Image(
                            image: AssetImage('images/no_image.png'),
                          ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            recordData.record.title,
                            style: const TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              recordData.record.description ?? 'あれれえ',
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Consumer<RelationData>(
                    builder: (context, relationData, child) {

                      final Relation relation = relationData.relations[index];
                      int relationId = 0;
                      String relationTitle = '';
                      String relationDesc = '';
                      String relationImg = '';
                      int relationKind = 0;
                      if (recordData.record.kind != 4) {
                        relationId = relation.personId;
                        relationTitle = relation.personName;
                        relationDesc = relation.personDesc;
                        relationImg = relation.personImg;
                        relationKind = 4;
                      } else {
                        relationId = relation.recordId;
                        relationTitle = relation.recordTitle;
                        relationDesc = relation.recordDesc;
                        relationImg = relation.recordImg;
                        relationKind = relation.recordKind;
                      }
                      Record record = new Record(
                          id: relationId,
                          title: relationTitle,
                          description: relationDesc,
                          imgUrl: relationImg,
                          kind: relationKind);

                      return InkWell(
                        onTap: () {
                          Provider.of<RecordData>(context, listen: false)
                              .newRecord(record);
                          Provider.of<RelationData>(context,
                                  listen: false)
                              .fetchRelations(relationId, relationKind);
                          Navigator.pushNamed(context, relationTitle);
                        },
                        child: Card(
                          child: ListTile(
                            leading: relationImg != ''
                                ? Image.network(
                                    relationImg,
                                    width: 200,
                                  )
                                : const Image(
                                    image: AssetImage('images/no_image.png'),
                                    width: 200,
                                  ),
                            title: Text(
                              recordKindName(relationKind) +
                                  relationTitle,
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            subtitle: Text(
                              relation.relateWords,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: Provider.of<RelationData>(context, listen: true)
                    .relations
                    .length,
              ),
            ),
          ],
        );
      },
    );
  }

  String recordKindName(int recordKind) {
    switch (recordKind) {
      case 1:
        return '函館市史デジタル版：';
      case 2:
        return '南北海道の文化財：';
      case 3:
        return '函館市中央図書館デジタル資料館：';
      case 4:
        return '函館ゆかりの人物伝：';
      default:
        return '不明';
    }
  }
}
