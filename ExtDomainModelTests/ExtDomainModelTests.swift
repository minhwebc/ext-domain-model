//
//  ExtDomainModelTests.swift
//  ExtDomainModelTests
//
//  Created by Quan Nguyen on 4/11/17.
//  Copyright © 2017 Quan Nguyen. All rights reserved.
//

import XCTest
import ExtDomainModel

class ExtDomainModelTests: XCTestCase {
    
    let tenUSD = Money(amount: 10, currency: "USD")
    let twelveUSD = Money(amount: 12, currency: "USD")
    let fiveGBP = Money(amount: 5, currency: "GBP")
    let fifteenEUR = Money(amount: 15, currency: "EUR")
    let fifteenCAN = Money(amount: 15, currency: "CAN")
        
    
    func testMoneyExtensions(){
        let tenUSD = Double(10).USD;
        let fiveGBP = 5.0.GBP;
        let fifteenEUR = 15.0.EUR;
        let fifteenCAN = 15.0.CAN;

        XCTAssert(tenUSD.amount == 10);
        XCTAssert(tenUSD.currency == "USD");
        
        XCTAssert(fiveGBP.amount == 5);
        XCTAssert(fiveGBP.currency == "GBP");
        
        XCTAssert(fifteenEUR.amount == 15);
        XCTAssert(fifteenEUR.currency == "EUR");
        
        XCTAssert(fifteenCAN.amount == 15);
        XCTAssert(fifteenCAN.currency == "CAN");
    }
    
    func testCustomStringProtocol() {
        let fiveGBP = 5.0.GBP;
        XCTAssert(fiveGBP.description == "GBP5.0")
        XCTAssert(tenUSD.description == "USD10.0")
        let person = Person(firstName: "Quan", lastName: "Nguyen", age: 20)
        XCTAssert(person.description == "Quan Nguyen 20")
        let job = Job(title: "driver", type: .Hourly(13.0))
        XCTAssert(job.description == "driver 13.0");
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
        
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        XCTAssert(family.description == "[Ted Neward 45, Charlotte Neward 45, ]");

    }
    
    func testAddUSDtoUSD() {
        let total = tenUSD.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    
    func testAddUSDtoGBP() {
        let total = tenUSD.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    
    func testSubtractUSDtoUSD() {
        let total = tenUSD.subtract(twelveUSD)
        XCTAssert(total.amount == -2)
        XCTAssert(total.currency == "USD")
    }
}
    

