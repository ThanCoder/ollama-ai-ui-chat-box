import 'package:flutter/material.dart';
import 'package:ollama_ai_chatbox/app/models/app_config_model.dart';

ValueNotifier<String> appRootPathNotifier = ValueNotifier('');
ValueNotifier<String> appDataRootPathNotifier = ValueNotifier('');
ValueNotifier<String> appConfigPathNotifier = ValueNotifier('');
ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier(false);
//config
ValueNotifier<AppConfigModel> appConfigNotifier =
    ValueNotifier(AppConfigModel());
