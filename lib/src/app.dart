import 'package:flutter/material.dart';
import 'widgets/record_list.dart';
import 'package:provider/provider.dart';
import 'models/record_data.dart';
import 'screens/record_detail.dart';
import 'models/relation_data.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecordData()),
        ChangeNotifierProvider(create: (context) => RelationData()),
      ],
      child: MaterialApp(
        title: '地域教材作成支援システム',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routes,
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == '/') {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('地域教材作成支援システム'),
          ),
          body: RecordList(),
        );
      },
      settings: settings,
    );
  } else {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('地域教材作成支援システム'),
          ),
          body: RecordDetail(),
        );
      },
      settings: settings,
    );
  }
}
