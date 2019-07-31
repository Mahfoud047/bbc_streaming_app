class Chain {
  String _name;
  String _url;

  Chain(
      this._name,
      this._url
      );


  String get name => _name;
  String get url => _url;

  factory Chain.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
//      throw FormatException("Null JSON provided to SimpleObject");
    }

    return Chain(
        json["name"],
        json["url"],
        );
  }
}

class Domain {
  final String _name;
  final int _id;
  final int _expertise;

  Domain(
    this._id,
    this._name,
    this._expertise,
  );

  int get id => _id;

  String get name => _name;

  int get expertise => _expertise;

  factory Domain.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
//      throw FormatException("Null JSON provided to SimpleObject");
    }

    return Domain(
      json["id"],
      json["name"],
      json["expertise"],
    );
  }
}
