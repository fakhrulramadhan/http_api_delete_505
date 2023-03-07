import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpku;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Beranda(),
    );
  }
}

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  //bikin variabel dulu
  String hasildata = "Belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Delete"),
        actions: [
          //utk get data dulu ketika diklik
          IconButton(
              onPressed: () async {
                var responseku = await httpku
                    .get(Uri.parse("https://reqres.in/api/users/2"));

                //ubah dari string ke objek
                Map<String, dynamic> dataku = json.decode(responseku.body);
                // Map<String, dynamic> dataku =
                //     json.decode(responseku.body) as Map<String, dynamic>;

                print(dataku);

                //utk perubahan tampilan / data
                setState(() {
                  //harus masuk ke dalam field data dulu utk akses fieldnya
                  hasildata =
                      "Nama: ${dataku['data']['first_name']} ${dataku['data']['last_name']}";
                });
              },
              icon: Icon(Icons.get_app))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          Text(hasildata),
          SizedBox(
            height: 17,
          ),
          ElevatedButton(
              onPressed: () async {
                var responsehapus = await httpku
                    .delete(Uri.parse("https://reqres.in/api/users/2"));

                // print(responsehapus.body); //isian data deletenya enggak ada
                //print(responsehapus.statusCode); //mengecek status

                //tembak ke api delete statuscode kalau statusnya 204
                //tidak benar2 menghapus, karena hanya testing saja
                if (responsehapus.statusCode == 204) {
                  setState(() {
                    hasildata = "Berhasil Hapus Data";
                  });
                }
                //Map<String, dynamic> datapus = json.decode(responsehapus.body);

                ///coba dulu print
                //print(datapus);
                // setState(() {

                // });
              },
              child: Text("Delete /  Hapus"))
        ],
      ),
    );
  }
}
