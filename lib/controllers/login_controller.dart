import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Error"),
              content: const Text("Please enter both email and password."),
            ),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final url = Uri.parse(
        "https://entrance-test-api.datahex.co/api/v1/auth/login/",
      );
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email.trim(), "password": password}),
      );

      Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final isSuccess = data['success'] == true;
        final user = data['user'];
        final name =
            user != null
                ? user['userDisplayName'] ?? user['fullName'] ?? "User"
                : null;

        if (isSuccess && name != null) {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text("Login Success"),
                  content: Text("Welcome $name"),
                ),
          );
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text("Login Failed"),
                  content: const Text("No user found with these credentials."),
                ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Login Failed"),
                content: const Text("Something went wrong. Please try again."),
              ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Error"),
              content: Text("Something went wrong: $e"),
            ),
      );
    }
  }
}
