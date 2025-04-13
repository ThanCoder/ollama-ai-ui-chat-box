import 'package:flutter/material.dart';
import 'package:ollama_ai_chatbox/app/pages/chat_page.dart';
import 'package:ollama_ai_chatbox/app/pages/left_side_page.dart';
import 'package:ollama_ai_chatbox/app/widgets/core/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      contentPadding: 0,
      body: Row(
        children: [
          SizedBox(
            width: 250,
            child: LeftSidePage(),
          ),
          Expanded(
            child: ChatPage(),
          ),
        ],
      ),
    );
  }
}
