//
//  DecodedData.swift
//  AdaProject
//
//  Created by user191120 on 8/17/21.
//

import Foundation

struct Response: Codable{
    var id: Int?
    var phoneNumber: String?
    var message: String?
    var location: String?
    var email: String?
    var validated: Bool?
    var token: String?
    var videos: [Videos]?
    var child: Child?
    var isReportable: isReportable?
    var profileCompleted: Bool?
}
struct Videos: Codable {
    var title: String
    var created: String
    var status: String
}
struct Child: Codable {
    var name: String?
    var estimatedBirthDate: String?
    var realBirthDate: String?
    var grams: Int?
    var sexuality: String?
    var doctorName: String?
}
struct isReportable: Codable {
    var status: Bool?
    var description: String?
}
