# Project Blueprint

## Overview

This project is a voice assistant that uses the Google Agent Framework with a Gemma 3B model and a Flutter UI for mobile and web. It will feature screen sharing, use a Supabase free cloud project for memory and context, and have live speech capabilities using a cloud-run serverless speech model like Chatter with Google Cloud Inference.

## Style, Design, and Features

### Implemented

*   **Initial Setup:** Basic Flutter project structure.
*   **Theme:**
    *   Light and Dark mode support using the `provider` package.
    *   Customizable `TextTheme` using `google_fonts`.
    *   Centralized `ThemeData` for both light and dark themes.
*   **UI:**
    *   A simple home page with a theme toggle button.
*   **Firebase Integration:**
    *   `firebase_core` and `firebase_ai` dependencies added.
    *   Firebase initialized in `main.dart`.
*   **Dependencies:**
    *   `google_fonts` for custom typography.
    *   `provider` for state management.

### Current Plan

1.  **Supabase Integration:**
    *   Add the `supabase_flutter` package.
    *   Initialize Supabase in `main.dart`.
    *   Create a Supabase project and get the credentials.
2.  **UI Development:**
    *   Create a home screen with a "start assistant" button.
    *   Create a voice assistant screen with:
        *   A button to start/stop voice input.
        *   A display for the conversation transcript.
        *   A button to enable screen sharing.
3.  **Voice Input and Speech-to-Text:**
    *   Add the `speech_to_text` package for microphone input.
    *   Integrate with a cloud-run serverless speech model for speech-to-text.
4.  **Text-to-Speech:**
    *   Add the `flutter_tts` package for text-to-speech output.
5.  **Google Agent Framework and Gemini:**
    *   Create a service to interact with the Gemini 3B model via the Google Agent Framework.
    *   The service will take text and/or screen sharing data as input.
    *   The service will return text and/or commands.
6.  **Screen Sharing:**
    *   Add the `flutter_webrtc` package for screen sharing.
    *   Capture the screen as a video stream.
    *   Send the stream to the Gemini service for processing.
7.  **State Management:**
    *   Use `provider` or `flutter_bloc` to manage the state of the voice assistant, including:
        *   Conversation history.
        *   Assistant status (listening, thinking, speaking).
        *   Screen sharing status.
8.  **Memory and Context:**
    *   Use Supabase to store and retrieve conversation history and user context.
