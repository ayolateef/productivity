import 'package:flutter/material.dart';
import 'package:productivity_app/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextStyle textStyle = const TextStyle(fontSize: 24);

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
      body: const Settings()
    );
  }

  void goToSettings(BuildContext context) {
    Navigator.pop(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtLong;
  late TextEditingController txtShort;


  static  const String WORKTIME = "workTime";
  static const  String SHORTBREAK= "shortBreak";
  static const String LONGBREAK = "longBreak";

   int workTime = 0;
   int shortBreak = 0;
   int longBreak = 0;

  late SharedPreferences prefs;

  int get buttonSize => 0;

  void Function(String key, int value) get setting => updateSetting;


  @override
  void initState() {
     txtWork = TextEditingController();
     txtShort = TextEditingController();
     txtLong = TextEditingController();
    readSettings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children:<Widget> [
        Text("Work", style: textStyle),
        const Text(''),
        const Text(''),
        SettingButton(const Color(0xff455a64), "-", buttonSize, 1,  WORKTIME, updateSetting.toString()),

        TextField(
          controller: txtWork,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number
        ),

        SettingButton(const Color(0xff455a64), "+", buttonSize, 1, WORKTIME, updateSetting.toString() ),
        Text("Short", style: textStyle),
        const Text(''),
        const Text(''),
        SettingButton(const Color(0xff455a64), "-", buttonSize, -1, SHORTBREAK, updateSetting.toString()),
        TextField(
          controller: txtShort,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),

      SettingButton(const Color(0xff455a64), "+", buttonSize, 1, SHORTBREAK, updateSetting.toString()),
        Text("Long", style: textStyle),
        const Text(''),
        const Text(''),
        SettingButton(const Color(0xff455a64), "-", buttonSize, -1, LONGBREAK, updateSetting.toString()),
        TextField(
          controller: txtLong,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),

        SettingButton(const Color(0xff009688), "+", buttonSize, 1, LONGBREAK, updateSetting.toString()),

        ],
      padding: const EdgeInsets.all(20.0),

    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if(workTime==null){
      await prefs.setInt(WORKTIME, int.parse('30'));
    }

    int?  shortBreak = prefs.getInt(SHORTBREAK);
    if(shortBreak==null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }

    int? longBreak = prefs.getInt(LONGBREAK);
    if(longBreak==null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }
  void updateSetting (String key, int value) {
    switch (key){
      case WORKTIME:
        {
          int? workTime = prefs.getInt(WORKTIME);
          workTime = value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? shortBreak= prefs.getInt(SHORTBREAK);
            shortBreak = value;
          if (shortBreak >= 1 && shortBreak <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtLong.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? longBreak= prefs.getInt(LONGBREAK);
          print(longBreak);
          if(longBreak != null ){
            longBreak += value;
            print(longBreak);
            if (longBreak >= 1 && longBreak <= 180) {
              prefs.setInt(LONGBREAK, longBreak);
              setState(() {
                txtLong.text = longBreak.toString();
                print(longBreak);
              });
            }
          }

        }
        break;
    }
  }

}
