import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:storage/MODEL/my_models.dart';
import 'package:storage/MODEL/services/shared_pref_service.dart';

class SharedPreference extends StatefulWidget {
  const SharedPreference({super.key});

  @override
  State<SharedPreference> createState() => _SharedPreferenceState();
}

class _SharedPreferenceState extends State<SharedPreference> {
  var _secilenRenkler = <String>[];

  var _secilenCinsiyet = Cinsiyet.KADIN;

  var _ogrenciMi = false;

  TextEditingController _nameController =
      TextEditingController(); //verileri tutmak için

  var _preferenceService = SharedPreferenceService();

  @override
  void initState() {
    super.initState();
    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference Use'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: ('Name Enter'),
              ),
            ),
          ),
          for (var item in Renkler.values) _buildCheckBoxListTile(item),
          for (var item in Cinsiyet.values)
            _buildRadioListTiles(describeEnum(item), item),
          SwitchListTile(
            title: const Text('Ogrenci misin'),
            value: _ogrenciMi,
            onChanged: (bool ogrenciMi) {
              setState(() {
                _ogrenciMi = ogrenciMi;
              });
            },
          ),
          TextButton(
            onPressed: () {
              var _userinformation = UserInformation(_nameController.text,
                  _secilenCinsiyet, _secilenRenkler, _ogrenciMi);
              _preferenceService.verileriKaydet(_userinformation);
            },
            child: Text('Kaydet'),
          )
        ],
      ),
    );
  }

  Widget _buildRadioListTiles(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
      title: Text(title),
      value: cinsiyet,
      groupValue: _secilenCinsiyet,
      onChanged: (Cinsiyet? secilmisCinsiyet) {
        setState(() {
          _secilenCinsiyet = secilmisCinsiyet!;
        });
      },
    );
  }

  Widget _buildCheckBoxListTile(Renkler renk) {
    return CheckboxListTile(
      title: Text(describeEnum(renk)),
      value: _secilenRenkler.contains(describeEnum(renk)),
      onChanged: (bool? deger) {
        if (deger == false) {
          _secilenRenkler.remove(describeEnum(renk));
        } else {
          _secilenRenkler.add(describeEnum(renk));
        }
        setState(() {});
        debugPrint(_secilenRenkler.toString());
      },
    );
  }

  void _verileriOku() async {
    var info = await _preferenceService.verileriOku();
    _nameController.text = info.isim;
    _secilenCinsiyet = info.cinsiyet;
    _secilenRenkler = info.renkler;
    _ogrenciMi = info.ogrenciMi;
    setState(() {});
  }
}
