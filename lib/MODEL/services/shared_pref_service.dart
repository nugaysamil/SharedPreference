import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/MODEL/my_models.dart';

class SharedPreferenceService {
  Future<UserInformation> verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    var _isim = preferences.getString('isim') ?? '';
    var _ogrenci = preferences.getBool('ogrenci') ?? false;
    preferences.getInt('cinsiyet');
    var _cinsiyet = Cinsiyet.values[preferences.getInt('cinsiyet') ?? 0];
    var _renkler = preferences.getStringList('renkler') ?? <String>[];

    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);
  }

  Future<void> verileriKaydet(UserInformation userInformation) async {
    final _name = userInformation.isim;

    final preferences = await SharedPreferences.getInstance();

    preferences.setString('isim', _name);
    preferences.setBool('Ogrenci', userInformation.ogrenciMi);
    preferences.setInt('Cinsiyet', userInformation.cinsiyet.index);
    preferences.setStringList('renkler', userInformation.renkler);
  }
}
