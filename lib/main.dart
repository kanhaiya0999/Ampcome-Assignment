import 'package:ampcome_assignment/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: SafeArea(
          child: SingleChildScrollView(
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Signup(),
              const SizedBox(
                height: 20,
              ),
              const CreateAccount(),
              const SizedBox(
                height: 20,
              ),
              const InputField(lebal: "First Name"),
              const SizedBox(
                height: 20,
              ),
              const InputField(lebal: "Last Name"),
              const SizedBox(
                height: 20,
              ),
              const NumberFiled(lebal: "Mobile Number"),
              const SizedBox(
                height: 20,
              ),
              const InputField(lebal: "Email"),
              const SizedBox(
                height: 20,
              ),
              const Genres(label: "Genres"),
            ]),
          ),
        ));
  }
}

class Genres extends StatefulWidget {
  const Genres({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  List<String> _genres = [];

  @override
  void initState() {
    super.initState();
    _getGenres();
  }

  Future<void> _getGenres() async {
    final response = await http
        .get(Uri.parse('https://apimocha.com/flutterassignment/getGenres'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final genres = data['data']['genres'] as List<dynamic>;
      setState(() {
        _genres = genres.map((genre) => genre['name'] as String).toList();
      });
    } else {
      throw Exception('Failed to load genres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.label}*",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _genres.length,
              itemBuilder: (context, index) {
                final genre = _genres[index];
                return ListTile(
                  title: Text(genre),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({Key? key, required this.lebal}) : super(key: key);
  final String lebal;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$lebal*",
              style: const TextStyle(color: whiltetextcolor),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              style: TextStyle(color: secondarycolor),
              cursorColor: secondarycolor,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: whiltetextcolor)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: whiltetextcolor, width: .2)),
              ),
            ),
          ],
        ));
  }
}

class NumberFiled extends StatelessWidget {
  const NumberFiled({Key? key, required this.lebal}) : super(key: key);
  final String lebal;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$lebal*",
              style: const TextStyle(color: whiltetextcolor),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: const TextStyle(color: secondarycolor),
              keyboardType: TextInputType.number,
              cursorColor: secondarycolor,
              decoration: InputDecoration(
                prefix: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: secondarycolor,
                  child: const Text("+91"),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: whiltetextcolor)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: whiltetextcolor, width: .2)),
              ),
            ),
          ],
        ));
  }
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: const [
          Text("Let's create you ",
              style: TextStyle(
                color: whiltetextcolor,
                fontSize: 30,
              )),
          Text("Account",
              style: TextStyle(
                color: secondarycolor,
                fontSize: 30,
              ))
        ],
      ),
    );
  }
}

class Signup extends StatelessWidget {
  const Signup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Sign Up",
            style: TextStyle(
              color: whiltetextcolor,
              fontSize: 15,
            ),
          ),
          Icon(
            Icons.close_outlined,
            color: whiltetextcolor,
          )
        ],
      ),
    );
  }
}
