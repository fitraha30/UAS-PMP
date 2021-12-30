class Contact {
  int _id;
  String _name;
  String _phone;

  Contact(this._name, this._phone);

  Contact.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._phone = map['phone'];
  }

  // ignore: unnecessary_getters_setters
  String get phone => _phone;

  // ignore: unnecessary_getters_setters
  set phone(String value) {
    _phone = value;
  }

  // ignore: unnecessary_getters_setters
  String get name => _name;

  // ignore: unnecessary_getters_setters
  set name(String value) {
    _name = value;
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }
}
