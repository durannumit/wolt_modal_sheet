import 'package:demo_ui_components/demo_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:wolt_state_management/wolt_state_management.dart';

class LoginScreenContent extends StatelessWidget {
  final StatefulValueListenable<bool> isLoggedIn;
  final void Function(String email, String password) onLoginPressed;

  const LoginScreenContent({
    Key? key,
    required this.isLoggedIn,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage('lib/assets/images/dash_coffee.webp'),
                    fit: BoxFit.cover,
                    height: 216,
                    width: 384,
                  ),
                  Text(
                    'Welcome to Coffee Maker!',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  const SizedBox(height: 50),
                  const AppTextFormField(
                    labelText: 'Username',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  const AppTextFormField(
                    labelText: 'Password',
                    obscureText: true,
                    autocorrect: false,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 30),
                  StatefulValueListenableBuilder<bool>(
                    valueListenable: isLoggedIn,
                    idleBuilder: (context, isLoggedIn) {
                      return WoltElevatedButton(
                        onPressed: () => onLoginPressed('email', 'password'),
                        child: const Text('Sign in'),
                      );
                    },
                    loadingBuilder: (context, _) {
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, _) {
                      return Column(
                        children: [
                          Text('Error: $error', style: const TextStyle(color: Colors.red)),
                          const SizedBox(height: 10),
                          WoltElevatedButton(
                            onPressed: () => onLoginPressed('email', 'password'),
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
