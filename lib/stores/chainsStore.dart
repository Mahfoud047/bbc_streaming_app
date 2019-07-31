import 'dart:async';
import 'dart:convert';
import 'package:audioplayer/audioplayer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:bbc_streaming/models/chain.dart';

enum LoadingState { loading, ready }


class ChainsStore with ChangeNotifier {
  List _chains = [];
  Chain _currentChain;
  LoadingState _loadingState = LoadingState.ready;

  bool _isPlaying = false;
  AudioPlayer _audioPlayer;

  ChainsStore(this._audioPlayer);

  List get chains => _chains;

  Chain get currentChain => _currentChain;

  bool get isPlaying => _isPlaying;

  LoadingState get loadingState => _loadingState;



  void playNewChain(Chain newChain) {
    _isPlaying = true;
    _currentChain = newChain;
    _audioPlayer.stop();
    _audioPlayer.play(newChain.url, isLocal: false);
  }

  void stopCurrentChain(){
    _isPlaying = false;
    _audioPlayer.stop();
  }

  void setLoadingState(LoadingState ldState){
    _loadingState = ldState;
    notifyListeners();
  }


  Future onPlay(Chain newChain) async {
    if (!_isPlaying) {
      playNewChain(newChain);
    } else {
      stopCurrentChain();
    }

    notifyListeners();
  }

  List<Chain> parseChains(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed['chains'].map<Chain>((json) => Chain.fromJson(json)).toList();
  }

  Future<List> initChains() async {
    // Make a HTTP GET request
    // Await basically pauses execution until the get() function returns a Response

    print('initChains');
    setLoadingState(LoadingState.loading);

    try {
      var url = "http://zmqze.mocklab.io/chains";

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final chains = parseChains(response.body);
        _chains = chains;

      } else {
        _chains = [];
      }
    } on Exception catch (e) {
      print('Exception...\n');
      print(e.toString());
      _chains = [];
    }

    setLoadingState(LoadingState.ready);
  }
}
