//
//  ContentView.swift
//  DoctorsApp
//
//  Created by Yash Patil on 16/02/23.
//

import SwiftUI


struct ContentView: View {
    
    
    
    @ObservedObject var postvm = PostViewModel()
    @ObservedObject var getvm = GetViewModel()
    
    
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var practiceFromMonth : String = ""
    @State private var practiceFromYear : String = ""
    @State private var selectedGender : Gender = .male
    
    @State var go : Bool = false
    var body: some View {
        
        NavigationStack {
            VStack(spacing:90) {
                
                VStack(spacing:10) {
                    Text("Basic Details")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Feel free to fill your details")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    VStack(alignment:.leading,spacing:7) {
                        Text("Full Name")
                        TextField("Name", text: $name)
                            .padding(.leading)
                            .frame(width: 370, height: 30)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                            }.autocorrectionDisabled(true)
                    }
                    VStack(alignment:.leading,spacing:7) {
                        Text("Email ID")
                        TextField("Email ID", text: $email)
                            .padding(.leading)
                            .frame(width: 370, height: 30)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                            }.autocorrectionDisabled(true)
                    }
                    VStack(alignment:.leading,spacing:7) {
                        Text("Gender")
                        HStack {
                          ForEach(genders,id: \.hashValue) { item in
                            Button {
                                selectedGender = item
                            } label: {
                                Text(item.rawValue)
                                    .foregroundColor(selectedGender == item ? .white : .orange)
                                    .frame(width: 100, height: 30, alignment: .center)
                                    .background {
                                        if selectedGender == item {
                                            RoundedRectangle(cornerRadius: 13)
                                                .foregroundColor(.orange)
                                        }else {
                                            RoundedRectangle(cornerRadius: 13)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.orange)
                                        }
                                    }
                                    
                            }
                          
                        }
                    }
                    .frame(width: 370,alignment: .leading)
                       
                    }
                    VStack(alignment:.leading,spacing:7) {
                        Text("Practicing From")
                        HStack {
                            TextField("Months", text: $practiceFromMonth)
                                .padding(.leading)
                                .frame(width: 160, height: 30)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                            }.autocorrectionDisabled(true)
                            .frame(width: 200,alignment: .leading)
                            TextField("Years", text: $practiceFromYear)
                                .padding(.leading)
                                .frame(width: 160, height: 30)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                            }.autocorrectionDisabled(true)
                        }
                    }
                }
                
                Button(action: GoFunc)
                  {
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                        .frame(width: 75, height: 75)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .shadow(radius: 7)
                        }
                }

            }.onAppear{
                getvm.getData(getURL: "")
            }
            .padding()
            .navigationDestination(isPresented: $go) {
                LoginView(username: postvm.userLoginDetails?.name ?? "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PostViewModel())
            
            
    }
}

extension ContentView {
    
    func GoFunc() {
            postvm.name = name
            postvm.email = email
            postvm.practiceFromYear = practiceFromYear
            postvm.practiceFromMonth = practiceFromMonth
            postvm.selectedGender = selectedGender
            postvm.postData()
            getvm.getData(getURL: postvm.userLoginDetails?.metadata.id ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            go = true
        }
        
    }
}
