enum Cinsiyet {
  // ignore: constant_identifier_names
  KADIN,
  // ignore: constant_identifier_names
  ERKEK,
  DIGER
}

enum Renkler {
  KIRMIZI,
  SARI,
  MAVI,
  PEMBE,
  YESIL,
}

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renkler;
  final bool ogrenciMi;

  UserInformation(this.isim, this.cinsiyet, this.renkler, this.ogrenciMi);
}
