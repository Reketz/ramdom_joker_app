class Joker {
  int id;
  String joker;

  Joker.fromJson(Map<dynamic, dynamic> json) {
    joker = json['value'] != null ? new Value.fromJson(json['value']).joke : null;
  }

  Joker.fromJsonSimple(Map<dynamic, dynamic> json) {
    id = json['ID'];
    joker = json['VALUE'];
  }
}

class Value {
  int id;
  String joke;

  Value({this.id, this.joke});

  Value.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    joke = json['joke'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['joke'] = this.joke;
    return data;
  }
}
