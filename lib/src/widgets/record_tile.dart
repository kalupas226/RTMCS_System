import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/record_data.dart';
import '../models/relation_data.dart';

class RecordTile extends StatelessWidget {
  final int recordIndex;
  final int recordId;
  final String recordTitle;
  final String recordDesc;
  final String recordImgUrl;
  final int recordKind;

  RecordTile(
      {this.recordIndex,
      this.recordId,
      this.recordTitle,
      this.recordDesc,
      this.recordImgUrl,
      this.recordKind});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(bottom: 16.0, right: 56.0),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Provider.of<RecordData>(context, listen: false)
                .createRecord(recordIndex);
            Provider.of<RelationData>(context, listen: false)
                .fetchRelations(recordId, recordKind);
            Navigator.pushNamed(context, recordTitle);
          },
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: recordImgUrl != ''
                    ? Image.network(recordImgUrl)
                    : const Image(image: AssetImage('images/no_image.png')),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Text(
                            recordTitle,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            recordKindName(recordKind),
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 3,
                      child: Text(
                        recordDesc,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String recordKindName(int recordKind) {
    switch (recordKind) {
      case 1:
        return '函館市史デジタル版';
      case 2:
        return '南北海道の文化財';
      case 3:
        return '函館市中央図書館デジタル資料館';
      case 4:
        return '函館ゆかりの人物伝';
      default:
        return '不明';
    }
  }
}
