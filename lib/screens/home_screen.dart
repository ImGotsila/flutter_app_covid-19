import 'package:covid_19/constants.dart';
import 'package:covid_19/models/DogService.dart';
import 'package:covid_19/models/character_data.dart';
import 'package:covid_19/screens/details_screen.dart';
import 'package:covid_19/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int confirmed, recovered, newConfirmed, deaths,newHospitalized,newDeaths,newRecovered,hospitalized;
  @override
  void initState() {
    super.initState();
    DogService.randomDog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: DogService.randomDog(),
                  builder: (context, snapshot) {
                    CharacterData msg = snapshot.data;
                    this.confirmed = msg.confirmed;
                    this.recovered = msg.recovered;
                    this.hospitalized = msg.hospitalized;
                    this.newConfirmed = msg.newConfirmed;
                    this.deaths = msg.deaths;
                    this.newDeaths = msg.newDeaths;
                    this.newRecovered = msg.newRecovered;
                    this.newHospitalized = msg.newHospitalized;
                    print(msg);
                    return Container();
                  }),
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: <Widget>[
                    InfoCard(
                      title: "Confirmed Cases",
                      icon: "assets/icons/emoji_sick.svg",
                      iconColor: Color(0xFFFF8C00),
                      effectedNum: this.confirmed,
                      press: () {},
                    ),
                    InfoCard(
                      title: "New Confirmed",
                      icon: "assets/icons/death.svg",
                      iconColor: Color(0xFFFF2D55),
                      effectedNum: this.newConfirmed,
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Recovered",
                      icon: "assets/icons/isolation.svg",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: this.recovered,
                      press: () {},
                    ),
                    InfoCard(
                      title: "New Recovered",
                      icon: "assets/icons/isolation.svg",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: this.newRecovered,
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Hospitalized",
                      icon: "assets/icons/isolation.svg",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: this.hospitalized,
                      press: () {},
                    ),
                    InfoCard(
                      title: "New Hospitalized",
                      icon: "assets/icons/isolation.svg",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: this.newHospitalized,
                      press: () {},
                    ),
                    InfoCard(
                      title: "New Cases",
                      icon: "assets/icons/emoji_sick.svg",
                      iconColor: Color(0xFF5856D6),
                      effectedNum: this.newDeaths,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Preventions",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      buildPreventation(),
                      SizedBox(height: 40),
                      buildHelpCard(context)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Row buildPreventation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventitonCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Wash Hands",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Use Masks",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Clean Disinfect",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 999 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        Container(
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/refresh.svg"),
            onPressed: () {
              setState(() {
                  //
                });
            },
          ),
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style:
              Theme.of(context).textTheme.body2.copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
