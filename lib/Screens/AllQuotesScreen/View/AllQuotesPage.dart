import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class AllQuotesPage extends StatefulWidget {
  const AllQuotesPage({Key? key}) : super(key: key);

  @override
  State<AllQuotesPage> createState() => _AllQuotesPageState();
}

class _AllQuotesPageState extends State<AllQuotesPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "${homeController.QuotesCategory.value} Quotes",
          style: GoogleFonts.lobster(
            color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: homeController.QuotesList.isNotEmpty
          ? ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: homeController.QuotesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              homeController.QuotesData.value = homeController.QuotesList[index];
              Get.toNamed('View');
            },
            child: Container(
              height: Get.height/3.6,
              width: Get.width,
              margin: EdgeInsets.all(Get.width/30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0,0),
                    blurRadius: 6
                  )
                ]
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: Get.width/21,right: Get.width/21,top: Get.width/10),
                      child: Text(
                        "${homeController.QuotesList[index]}",
                        style: GoogleFonts.lobster(
                          color: Colors.black,
                          fontSize: 12.sp
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Get.width/15,left: Get.width/5,right: Get.width/5,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                            },
                            icon: Icon(Icons.done_all,color: Colors.black,),
                          ),
                          IconButton(
                            onPressed: () {
                            },
                            icon: Icon(Icons.star,color: Colors.black,),
                          ),
                          IconButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: "${homeController.QuotesList[index]}"));
                              Get.snackbar('Thank You', "This Quotes Is Copied");
                            },
                            icon: Icon(Icons.copy,color: Colors.black,),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(child: Text("Value Not Available",style: GoogleFonts.lobster(color: Colors.black,fontSize: 15.sp),),),
    );
  }
}
