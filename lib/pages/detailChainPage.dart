import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bbc_streaming/models/chain.dart';
import 'package:bbc_streaming/stores/chainsStore.dart';

class DetailChainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final chain = Provider.of<Chain>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chain.name,
        ),
      ),
      body: Consumer<ChainsStore>(
        builder: (context, chainsStore, child) => Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SizedBox(
                        width: 10.0,
                        height: 10.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                        ),
                      ),
                    ),
                    Text('Live', style: TextStyle(fontSize: 18.0)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 40.0,
                        color: Colors.black87,
                      ),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      onPressed: () => chainsStore.onPlay(chain),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: CircleBorder(),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(90.0),
                            )),
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: Icon(
                          chainsStore.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 80.0,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          size: 40.0,
                          color: Colors.black87,
                        ),
                        onPressed: () {})
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
