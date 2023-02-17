//
//  OptionView.swift
//  DoctorsApp
//
//  Created by Yash Patil on 16/02/23.
//

import SwiftUI

struct OptionView: View {
    
    let option : Options
    var backColor : Color = .white
    var body: some View {
        VStack {
            if option.name == "Scan" || option.name == "My Bookings" {
                option.image
                    .font(.custom("df", size: 30))
                    .padding(.bottom,5)
            }else {
               
                option.image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purple)
                    .frame(width: 50, height: 50)
            }
            Text(option.name)
                .font(.subheadline)
        }
        .frame(width: 100, height: 90)
        .background(backColor)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.vertical,10)
        
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView(option: Options(image: Image("ambulance"), name: "Ambulance"))
    }
}
