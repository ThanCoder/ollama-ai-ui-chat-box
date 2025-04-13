import 'package:flutter/material.dart';
import 'package:ollama_ai_chatbox/app/general_server/general_services.dart';
import 'package:ollama_ai_chatbox/app/my_app.dart';
import 'package:ollama_ai_chatbox/app/notifiers/app_notifier.dart';
import 'package:ollama_ai_chatbox/app/services/core/app_config_services.dart';
import 'package:than_pkg/than_pkg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThanPkg.windowManagerensureInitialized();

  //init config
  await initAppConfigService();

  await GeneralServices.instance.init();

  isDarkThemeNotifier.value = true;
  runApp(const MyApp());
}
