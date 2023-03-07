import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:sizer/sizer.dart';

class SeeAllQuotesPage extends StatefulWidget {
  const SeeAllQuotesPage({Key? key}) : super(key: key);

  @override
  State<SeeAllQuotesPage> createState() => _SeeAllQuotesPageState();
}

class _SeeAllQuotesPageState extends State<SeeAllQuotesPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "All Category Quotes",
          style: GoogleFonts.lobster(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: homeController.CategoryList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
             // homeController.QuotesData.value = homeController.QuotesList[index];
              //Get.toNamed('View');
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
                    alignment: Alignment.center,
                    child: Container(
                      height: Get.height/3.6,
                      width: Get.width,
                      child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.memory(homeController.CategoryList[index].image!,fit: BoxFit.fill,)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${homeController.CategoryList[index].Category} Quotes",
                      style: GoogleFonts.lobster(
                          color: Colors.white,
                          fontSize: 30.sp
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
