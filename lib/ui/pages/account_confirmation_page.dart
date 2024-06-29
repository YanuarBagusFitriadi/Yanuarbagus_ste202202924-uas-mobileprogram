part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;
  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
          body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: defaultmargin),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 22),
                  height: 56,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSplashPage());
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(" Konfirmasi\nAkun Baru",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (widget.registrationData.profileImage == null)
                              ? AssetImage("assets/user_pic.png")
                              : FileImage(widget.registrationData.profileImage),
                          fit: BoxFit.cover)),
                ),
                Text(
                  "Selamat Datang ",
                  style: blackTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Text(
                  "${widget.registrationData.name}",
                  textAlign: TextAlign.center,
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
                SizedBox(height: 110),
                (isSigningUp)
                    ? SpinKitFadingCircle(
                        color: Color(0xFF3E9D9D),
                        size: 45,
                      )
                    : SizedBox(
                        width: 250,
                        height: 45,
                        child: RaisedButton(
                          color: Color(0xFF3E9D9D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            setState(() {
                              isSigningUp = true;
                            });

                            imageFileToUpload =
                                widget.registrationData.profileImage;
                            SignInSignUpResult result =
                                await AuthService.signUp(
                              widget.registrationData.email,
                              widget.registrationData.password,
                              widget.registrationData.name,
                            );

                            if (result == null) {
                              setState(() {
                                isSigningUp = false;
                              });
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: result.message,
                              )..show(context);
                            }
                          },
                          child: Text("Creat My Account",
                              style: whiteTextFont.copyWith(fontSize: 16)),
                        ),
                      ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
