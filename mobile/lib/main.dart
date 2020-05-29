import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mobile/store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Store(),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store _store = Provider.of<Store>(context);
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/success": (context) => SuccessPage(),
      },
      theme: _store.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  Map _username = {
    "value": "",
    "valid": false,
  };
  Map _email = {
    "value": "",
    "valid": false,
  };
  Map _password = {
    "value": "",
    "valid": false,
    "visible": false,
  };
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pushNamed(context, "/success");
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  _validateUsername(val) {
    final RegExp regex = RegExp(r"^[a-zA-Z0-9_.-]+$");
    if (val.length < 5) {
      return "Username must be at least 5 characters";
    } else if (!regex.hasMatch(val)) {
      return "Must be alphanumeric or contain - or _";
    } else {
      return null;
    }
  }

  void _verifyUsername(val) {
    setState(() {
      _username["valid"] = _validateUsername(val) == null;
    });
  }

  _validateEmail(val) {
    final RegExp regex =
        RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (val.isEmpty) {
      return "Please provide a email";
    } else if (!regex.hasMatch(val)) {
      return "Please provide a valid email";
    } else {
      return null;
    }
  }

  void _verifyEmail(val) {
    setState(() {
      _email["valid"] = _validateEmail(val) == null;
    });
  }

  _validatePassword(val) {
    final RegExp regex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$");
    if (val.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!regex.hasMatch(val)) {
      return "Password must contain at least one uppercase, one lowercase and one number";
    } else {
      return null;
    }
  }

  void _verifyPassword(val) {
    setState(() {
      _password["valid"] = _validatePassword(val) == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double navHeight = MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final Store _store = Provider.of<Store>(context);
    final ThemeData _theme = _store.getTheme();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: navHeight),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.05,
              left: width * 0.1,
              right: width * 0.1,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        child: Image.asset(
                          _store.getIllustration(),
                          width: width * 2,
                        ),
                      ),
                      Positioned(
                        right: width * -0.05,
                        child: InkWell(
                          onTap: () => _store.toggleMode(),
                          child: Image.asset(_store.getIcon()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: Text(
                      "Join Us",
                      style: _theme.textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: Text(
                      "Be a part of something greater",
                      style: _theme.textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Form(
                    autovalidate: _autoValidate,
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(
                            color: _store.isDark()
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF000000),
                          ),
                          cursorColor: _store.isDark()
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF000000),
                          keyboardType: TextInputType.text,
                          keyboardAppearance: _theme.brightness,
                          validator: (val) => _validateUsername(val),
                          onSaved: (val) {
                            setState(() {
                              _username["value"] = val;
                            });
                          },
                          onChanged: (val) => _verifyUsername(val),
                          decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "johndoe",
                            hintStyle: TextStyle(color: Color(0xFF939393)),
                            suffixIcon: Icon(
                              _username["valid"] ? Icons.check : Icons.close,
                              color: !_autoValidate
                                  ? Colors.transparent
                                  : _username["valid"]
                                      ? Color(0xFF00C851)
                                      : Color(0xFFB00020),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _username["valid"] && _autoValidate
                                    ? Color(0xFF00C851)
                                    : _store.isDark()
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 20.0,
                              color: _username["valid"] && _autoValidate
                                  ? Color(0xFF00C851)
                                  : _autoValidate && !_username["valid"]
                                      ? Color(0xFFB00020)
                                      : _store.isDark()
                                          ? Color(0xFFFFFFFF)
                                          : Color(0xFF000000),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            focusColor: _store.isDark()
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF000000),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB00020)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB00020),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: _username["valid"] && _autoValidate
                                    ? Color(0xFF00C851)
                                    : _store.isDark()
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: _store.isDark()
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF000000),
                          ),
                          cursorColor: _store.isDark()
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF000000),
                          keyboardType: TextInputType.text,
                          validator: (val) => _validateEmail(val),
                          onSaved: (val) {
                            setState(() {
                              _email["value"] = val;
                            });
                          },
                          onChanged: (val) => _verifyEmail(val),
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "johndoe@gmail.com",
                            hintStyle: TextStyle(color: Color(0xFF939393)),
                            suffixIcon: Icon(
                              _email["valid"] ? Icons.check : Icons.close,
                              color: !_autoValidate
                                  ? Colors.transparent
                                  : _email["valid"]
                                      ? Color(0xFF00C851)
                                      : Color(0xFFB00020),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _email["valid"] && _autoValidate
                                    ? Color(0xFF00C851)
                                    : _store.isDark()
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 20.0,
                              color: _email["valid"] && _autoValidate
                                  ? Color(0xFF00C851)
                                  : _autoValidate && !_email["valid"]
                                      ? Color(0xFFB00020)
                                      : _store.isDark()
                                          ? Color(0xFFFFFFFF)
                                          : Color(0xFF000000),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            focusColor: _store.isDark()
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF000000),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB00020)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB00020),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: _email["valid"] && _autoValidate
                                    ? Color(0xFF00C851)
                                    : _store.isDark()
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: _store.isDark()
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF000000),
                          ),
                          cursorColor: _store.isDark()
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF000000),
                          keyboardType: TextInputType.text,
                          validator: (val) => _validatePassword(val),
                          onSaved: (val) {
                            setState(() {
                              _password["value"] = val;
                            });
                          },
                          onChanged: (val) => _verifyPassword(val),
                          obscureText: !_password["visible"],
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "password",
                            hintStyle: TextStyle(color: Color(0xFF939393)),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _password["visible"] = !_password["visible"];
                                });
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Color(0xFF939393),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _password["valid"] && _autoValidate
                                    ? Color(0xFF00C851)
                                    : _store.isDark()
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 20.0,
                              color: _password["valid"] && _autoValidate
                                  ? Color(0xFF00C851)
                                  : _autoValidate && !_password["valid"]
                                      ? Color(0xFFB00020)
                                      : _store.isDark()
                                          ? Color(0xFFFFFFFF)
                                          : Color(0xFF000000),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            focusColor: _store.isDark()
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF000000),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB00020)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB00020),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: _password["valid"] && _autoValidate
                                    ? Color(0xFF00C851)
                                    : _store.isDark()
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  InkWell(
                    onTap: _validateInputs,
                    child: Container(
                      width: double.infinity,
                      height: height * 0.075,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: _theme.textTheme.button.backgroundColor,
                      ),
                      child: Text(
                        "Register",
                        style: _theme.textTheme.button,
                      ),
                    ),
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

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store _store = Provider.of<Store>(context);
    return Scaffold(
      body: Center(
        child: FlareActor(
          _store.isDark() ? "images/success-dark.flr" : "images/success.flr",
          animation: "Untitled",
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
