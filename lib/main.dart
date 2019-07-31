import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:provider/provider.dart';
import 'package:bbc_streaming/router.dart';

import 'package:bbc_streaming/widgets/chain_item_list.dart';

import 'stores//chainsStore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) =>
          ChainsStore(AudioPlayer())
            ..initChains(),
        ),
      ],
      child: MaterialApp(
        title: 'BBC Streaming',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(title: 'BBC Streaming'),
        },
        onGenerateRoute: Router.generateRoute,
        onUnknownRoute: (settings) =>
            MaterialPageRoute(
              builder: (_) =>
                  Scaffold(
                    body: Center(
                      child: Text('No route defined for ${settings.name}'),
                    ),
                  ),
            ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final chainsStore = Provider.of<ChainsStore>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
              child: chainsStore.loadingState == LoadingState.loading
                  ? Text('Loading Channels')
                  : buildListItems(chainsStore),
        )),);
  }

  Widget buildListItems(store) {
    return ListView.builder(
      itemCount: store.chains.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return ChainItemList(store.chains[index]);
      },
    );
  }
}
