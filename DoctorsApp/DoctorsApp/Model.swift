//
//  Model.swift
//  DoctorsApp
//
//  Created by Yash Patil on 16/02/23.
//

import Foundation
import SwiftUI

struct PostModel: Codable {
    var d: UserDetails?
}

struct UserDetails  : Codable {
    let metadata: Metadata
    let doctorsID, name, email, gender: String
    let practiceFrmMonth, practiceFrmYear: String

    enum CodingKeys: String, CodingKey {
        case metadata = "__metadata"
        case doctorsID = "doctors_id"
        case name, email, gender
        case practiceFrmMonth = "practice_frm_month"
        case practiceFrmYear = "practice_frm_year"
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    let id, uri: String
    let type: String
}

enum Gender : String  {
    case male = "Male"
    case female = "Female"
    case others = "Others"
}

let genders : [Gender] = [.male,.female,.others]




struct Options {
    let image : Image
    let name : String
}

let allOptions : [Options] = [Options(image: Image(systemName: "qrcode"), name: "Scan"),
                              Options(image: Image("vaccine"), name: "Vaccine"),
                              Options(image: Image(systemName: "list.clipboard.fill"), name: "My Bookings"),
                              Options(image: Image("clinic"), name: "Clinic"),
                              Options(image: Image("ambulance"), name: "Ambulance"),
                              Options(image: Image("nurse"), name: "Nurse")]
