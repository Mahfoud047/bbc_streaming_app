import 'package:bbc_streaming/stores/chainsStore.dart';
import 'package:flutter/material.dart';
import 'package:bbc_streaming/models/chain.dart';
import 'package:bbc_streaming/pages/detailChainPage.dart';
import 'package:provider/provider.dart';

class ChainItemList extends StatefulWidget {
  Chain _chain;

  ChainItemList(this._chain);

  @override
  _ChainItemListState createState() => _ChainItemListState();
}

class _ChainItemListState extends State<ChainItemList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final chainsStore = Provider.of<ChainsStore>(context);

    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
        title: Text(this.widget._chain.name),
        trailing: IconButton(
          icon: _isLoading
              ? Icon(Icons.hourglass_empty)
              : chainsStore.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: () {
            print(widget._chain.url);
            setState(() {
              _isLoading = true;
            });
            chainsStore.onPlay(widget._chain).then(
                (val) => setState(() {
                  _isLoading = false;
                })
            );
          },
        ),
        onTap: () {
          Navigator.pushNamed(context, '/chain_detail', arguments: widget._chain);
        },
      ),
    );
  }
}
