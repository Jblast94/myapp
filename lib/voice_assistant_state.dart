import 'package:flutter/material.dart';
import 'package:myapp/gemini_service.dart';

class VoiceAssistantState extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    _isLoading = true;
    notifyListeners();

    _messages.add(Message(text: text, isUser: true));
    final response = await _geminiService.generateText(text);
    _messages.add(Message(text: response, isUser: false));

    _isLoading = false;
    notifyListeners();
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
