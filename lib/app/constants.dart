import 'package:flutter/material.dart';

//debug
const isDebugPrint = false;

//chapt url
const chaptApiUrl = "http://localhost:11434/api/generate";
/*
{
  "model": "deepseek-r1:1.5b",
  "prompt": "hello",
  "stream": false
}
*/
const chaptModelApiUrl = "http://localhost:11434/api/tags";
//assets
const defaultIconAssetsPath = 'assets/cover.webp';
//version name
const appVersionName = 'beta-test-1';
const appName = 'ollama_ai_chatbox';
const appTitle = 'Ollama AI Chatbox';
const androidRootPath = "/storage/emulated/0";
//config
const appConfigFileName = 'main.config.json';
const appMainDatabaseName = 'main.db.json';
const appGenresDatabaseName = 'genres.db.json';
const appSubNoteDatabaseName = 'subnote.db.json';
//novel status color
final novelStatusOnGoingColor = Colors.teal[900];
final novelStatusCompletedColor = Colors.blue[900];
const novelStatusAdultColor = Colors.red;

final activeColor = Colors.teal[600];
const dangerColor = Colors.red;
final disableColor = Colors.grey[200];

//server
const serverPort = 3300;
