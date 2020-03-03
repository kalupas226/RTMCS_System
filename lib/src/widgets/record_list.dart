import 'package:flutter/material.dart';
import './record_tile.dart';
import 'package:provider/provider.dart';
import '../models/record_data.dart';
import '../models/record.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class RecordList extends StatelessWidget {
  final SearchBarController<Record> _searchBarController =
      SearchBarController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordData>(
      builder: (context, recordData, child) {
        return SearchBar<Record>(
          searchBarController: _searchBarController,
          searchBarPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
          headerPadding: const EdgeInsets.only(left: 16.0),
          listPadding: const EdgeInsets.all(16.0),
          onSearch:
              Provider.of<RecordData>(context, listen: true).fetchRecords,
          emptyWidget: const Text('検索結果なし'),
          cancellationWidget: const Text('Cancel'),
          header: Row(
            children: <Widget>[
              Checkbox(
                value: recordData.isJinbutsuChecked,
                onChanged: (value) {
                  recordData.changeJinbutsuCheck();
                  _searchBarController.replayLastSearch();
                },
              ),
              const Text('函館ゆかりの人物伝'),
              const SizedBox(width: 20),
              Checkbox(
                value: recordData.isShishiChecked,
                onChanged: (value) {
                  recordData.changeShishiCheck();
                  _searchBarController.replayLastSearch();
                },
              ),
              const Text('函館市史デジタル版'),
              const SizedBox(width: 20),
              Checkbox(
                value: recordData.isWebmapChecked,
                onChanged: (value) {
                  recordData.changeWebmapCheck();
                  _searchBarController.replayLastSearch();
                },
              ),
              const Text('南北海道の文化財'),
              const SizedBox(width: 20),
              Checkbox(
                value: recordData.isDigitalChecked,
                onChanged: (value) {
                  recordData.changeDigitalCheck();
                  _searchBarController.replayLastSearch();
                },
              ),
              const Text('デジタル資料館'),
            ],
          ),
          onItemFound: (Record record, int index) {
            return RecordTile(
              recordIndex: index,
              recordId: record.id,
              recordTitle: record.title,
              recordDesc: record.description,
              recordImgUrl: record.imgUrl,
              recordKind: record.kind,
            );
          },
        );
      },
    );
  }
}
