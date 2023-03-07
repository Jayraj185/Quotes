import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quotes/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:quotes/Utils/DBHelper/CategoryDatabase.dart';
import 'package:quotes/Utils/DBHelper/QuotesDatabase.dart';
import 'package:sizer/sizer.dart';

class QuotesAddPage extends StatefulWidget {
  const QuotesAddPage({Key? key}) : super(key: key);

  @override
  State<QuotesAddPage> createState() => _QuotesAddPageState();
}

class _QuotesAddPageState extends State<QuotesAddPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.CategoryId.value = 0;
    homeController.GetData();
    homeController.GetData2();

    if(homeController.CategoryList.isNotEmpty)
    {
      homeController.DropdownValue.value = homeController.CategoryList[0].Category!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: homeController.key2.value,
          child: Obx(
                () => homeController.CategoryList.isEmpty
                ? Center(child: Text("Please Add Category",style: GoogleFonts.lobster(color: Colors.black,fontSize: 15.sp),))
                : Column(
              children: [
                Container(
                  height: Get.height / 18,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(left: Get.width / 21, right: Get.width / 21, top:  Get.height / 90),
                  padding: EdgeInsets.only(left: Get.width/21),
                  child: TextFormField(
                    controller: homeController.txtAddQuotes.value,
                    style: GoogleFonts.lobster(),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Quotes Required*",
                      // prefix: Container(),
                      // prefixIconColor: Colors.black,
                      hintStyle: GoogleFonts.lobster(),
                    ),
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Required* Please Add This Value";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  height: Get.height / 18,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(left: Get.width / 21, right: Get.width / 21, top:  Get.height / 90),
                  padding: EdgeInsets.symmetric(horizontal: Get.width/21),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton(
                        onChanged: (value) {
                          homeController.DropdownValue.value = value!;
                        },
                        items: homeController.CategoryList.asMap().entries.map((e) =>
                            DropdownMenuItem(
                              child: Text("${homeController.CategoryList[e.key].Category}",style: GoogleFonts.lobster(),),
                              value: "${homeController.CategoryList[e.key].Category}",
                              onTap: () {
                                print("==== ${e.key}");
                                homeController.CategoryId.value = e.key;
                                print("==== ${homeController.CategoryId.value}   ${homeController.CategoryList[homeController.CategoryId.value].id}");
                              },
                            ),
                        ).toList(),
                        value: "${homeController.DropdownValue}",
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(homeController.key2.value.currentState!.validate())
                    {
                      print("==== ${homeController.CategoryId.value}   ${homeController.CategoryList[homeController.CategoryId.value].id}");
                      QuotesDatabase.quotesDatabase.InsertQutesData(Quote: homeController.txtAddQuotes.value.text, Category_Id: homeController.CategoryList[homeController.CategoryId.value].id!);
                      homeController.GetData2();
                      Get.back();
                      homeController.txtAddQuotes.value.clear();
                    }
                    else
                    {
                      Get.snackbar('Alert', "Please Add Your Data");
                    }
                  },
                  child: Container(
                      height: Get.height / 18,
                      width: Get.width / 2.1,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: Get.width / 21, right: Get.width / 21, top:  Get.height / 21),
                      alignment: Alignment.center,
                      child: Text(
                        "Add Quotes",
                        style: GoogleFonts.lobster(
                            fontSize: 15.sp,
                            color: Colors.black
                        ),
                      )
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
