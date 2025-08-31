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

### Current Plan

1.  **Firebase Integration:**
    *   Add `firebase_core` and `firebase_ai` dependencies.
    *   Initialize Firebase in `main.dart`.
2.  **Voice Assistant UI:**
    *   Create a dedicated screen for the voice assistant.
    *   Add buttons for starting and stopping recording.
    *   Display the conversation history.
3.  **Gemini Service:**
    *   Create a service to interact with the Gemini API.
    *   Implement text generation from prompts.
    *   Implement multimodal input (text and audio).
4.  **State Management:**
    *   Use `provider` to manage the state of the voice assistant.
5.  **Dependencies:**
    *   Add `google_fonts` for custom typography.
    *   Add `provider` for state management.
