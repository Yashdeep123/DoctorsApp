//
//  LoginView.swift
//  DoctorsApp
//
//  Created by Yash Patil on 16/02/23.
//

import SwiftUI

struct LoginView: View {
   
    
    @ObservedObject var getvm = GetViewModel()
    @ObservedObject var postvm = PostViewModel()
    @State var selectedOption : String = ""
    
    var username : String = ""
    init(username: String) {
        self.username = username
    }
    let columns :[GridItem] = [GridItem(.fixed(120)),GridItem(.fixed(120)),GridItem(.fixed(120))]
   
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.purple.opacity(0.7),.white], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing:30) {
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 50, height: 50)
                    VStack(alignment:.leading) {
                        Text("Hello,")
                        Text(username)
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    Image(systemName: "bell")
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }

                    TextField("Search...", text: .constant(""))
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.white)
                        .shadow(radius: 5)
                    
                }.frame(width: 330)
                
                    Image("doctor")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding(10)
                        .overlay(alignment: .topTrailing) {
                            Button {
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.caption)
                                    .padding(9)
                                    .tint(.white)
                                    .background(.orange)
                                    .clipShape(Circle())
                                    .frame(width: 30, height: 30)
                                    
                            }
                        }
               
                  Text("At your Fingertip")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)

                LazyVGrid(columns: columns, alignment: .center, spacing: 5) {
                    ForEach(allOptions,id:\.name) { option in
                        Button {
                            selectedOption = option.name
                        } label: {
                            OptionView(option: option,backColor: selectedOption == option.name ? .orange.opacity(0.9) : .white)
                        }
                        .tint(.black)

                    }
                }
                
            }.padding(.horizontal)
        }.ignoresSafeArea()
            
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(username: "")
    }
}
