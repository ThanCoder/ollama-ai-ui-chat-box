import 'package:flutter/material.dart';
import 'package:ollama_ai_chatbox/app/my_app.dart';
import 'package:ollama_ai_chatbox/app/notifiers/app_notifier.dart';
import 'package:ollama_ai_chatbox/app/services/app_config_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //url
  // const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  // const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  // await Supabase.initialize(
  //   url: supabaseUrl,
  //   anonKey: supabaseKey,
  // );

  // if (Platform.isLinux) {
  //   await WindowManager.instance.ensureInitialized();
  // }
  //init config
  await initConfig();
  isDarkThemeNotifier.value = true;
  runApp(const MyApp());
}
