// ignore_for_file: deprecated_member_use

import 'package:alsagr_app/components/footer.dart';
import 'package:flutter/material.dart';
import 'package:alsagr_app/components/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  void openSocialMedia(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التواصل'),
        actions: [
          ClipOval(
            child: Image.asset('assets/Alsaaqerclub.jpg'),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 86, 45, 93),
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'تواصل معنا',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'أدخل اسمك',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set the desired border radius here
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'أدخل رقم جوالك',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set the desired border radius here
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'أدخل بريدك الألكتروني',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set the desired border radius here
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'الموضوع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Set the desired border radius here
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                // call api to post information to, if success = clear fields show success msg, false show faild msg & don't clear fields
                bool sent = true; // نتيجة تسليم الفورم
                if (sent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تم ارسال البيانات بنجاح")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 55, 122, 58), // Set the desired color here
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 20), // Adjust the padding here
                textStyle:
                    const TextStyle(fontSize: 18), // Adjust the font size here
              ),
              child: const Text('إرسال'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 5.0), // Change the value to adjust the padding size
              child: Center(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Footer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
