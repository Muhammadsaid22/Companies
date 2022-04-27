import 'package:companies_items_a/cubit/company/company_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
class ComoaniesList extends StatelessWidget {
  void showbottom(context,String? image,name ,description) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: (440.0),
            width: (375.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.orange.shade900,
                      Colors.orange.shade800,
                      Colors.orange.shade400
                    ]
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                 Container(
                     height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child:image != null ?  Image.network(
                      image,
                      fit: BoxFit.cover,
                    ) : Image.asset("assets/images.jpg",
                      fit: BoxFit.cover,)
                    ),
                  Text(
                    "\n${name}\n",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Text(description,
                  style: TextStyle(
                    fontSize: 18
                  ),
                  )

                ],
              ),
            ),
          ),
        );
      },
    );
  }
  String token;
  ComoaniesList(this.token);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:BlocProvider(
          create: (context) => CompanyCubit()..companyInfo(token),
              child: BlocBuilder<CompanyCubit,CompanyState>(
                builder: (context,state) {
                  if(state is CompanyInitial || state is CompanyLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(state is CompanyLoaded){
                    return Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [
                                  Colors.orange.shade900,
                                  Colors.orange.shade800,
                                  Colors.orange.shade400
                                ]
                            )
                        ),
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                            itemCount: state.companyList.items.length,
                            itemBuilder: (context,index)=>Container(
                              margin: EdgeInsets.all(6),
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.red.shade900
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                  onTap: (){
                                    showbottom(
                                      context,

                                        state.companyList.items[index].logo,
                                        state.companyList.items[index].welcome_text,
                                        state.companyList.items[index].description);
                                    },
                                  title: Text(state.companyList.items[index].name),
                                  subtitle: Row(
                                    
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.blue,
                                      ),
                                      Text(state.companyList.items[index].city),
                                    ],
                                  ),
                                  trailing: Container(
                                    height: 40,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(
                                      child: Text(state.companyList.items[index].status,
                                      style: TextStyle(
                                        color: Colors.white
                                      ),),
                                    ),
                                  )
                              ),
                            ))
                    );
                  }
                  else if (state is CompanyError) {
                    return Center(
                      child: Text(state.error??'Connot open ',),
                    );
                  } else {
                    return Center(
                      child: Text("Unknown State !"),
                    );
                  }
                  },
              ),
      )
    );
  }
}
