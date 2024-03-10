import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // El usuario se ha autenticado correctamente
        final AccessToken accessToken = result.accessToken!;
        print('Token de acceso: ${accessToken.token}');
        // Puedes usar el token de acceso para hacer llamadas a la API de Facebook
      } else {
        // Hubo un error durante la autenticación
        print('Error al iniciar sesión con Facebook');
      }
    } catch (e) {
      // Manejar errores
      print('Error: $e');
    }
  }

  void _launchURL() async {
    const url = 'https://www.facebook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Connect'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _loginWithFacebook,
              child: Text('Conectar con Facebook'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _launchURL,
              child: Text(
                'Visitar sitio web',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
