import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:bbc_streaming/pages/detailChainPage.dart';

import 'models/chain.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/chain_detail':
        var chain = settings.arguments as Chain;
        return MaterialPageRoute(
          builder: (_) => Provider.value(value: chain, child: DetailChainPage()),
        );
      default:
        return null;
    }
  }
}
