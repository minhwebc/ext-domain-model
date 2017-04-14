//
//  main.swift
//  ExtDomainModel
//
//  Created by Quan Nguyen on 4/11/17.
//  Copyright © 2017 Quan Nguyen. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

public protocol CustomStringConvertible {
    var description : String { get }
}

public protocol Mathematics {
    func add(_ to : Money) -> Money
    func subtract(_ from: Money) -> Money
}
extension Double {
    public var USD: Money { return Money(amount : Int(self), currency: "USD") }
    public var EUR: Money { return Money(amount : Int(self), currency: "EUR") }
    public var CAN: Money { return Money(amount : Int(self), currency: "CAN") }
    public var GBP: Money { return Money(amount : Int(self), currency: "GBP") }
}
////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    public var description : String {
        return "\(currency)\(Double(amount))";
    }
    
    public func convert(_ to: String) -> Money {
        if(to != "USD" && to != "GBP" && to != "EUR" && to != "CAN"){
            print("There was an error!");
        }
        var result : Money = Money(amount: self.amount, currency: to);
        if(self.currency == "USD"){
            if(to == "GBP"){
                result.currency = "GBP";
                result.amount = self.amount / 2;
            }else if(to == "EUR"){
                result.currency = "EUR";
                result.amount = Int(Double(self.amount) * 1.5);
            }else{
                result.currency = "CAN";
                result.amount = Int(Double(self.amount) * 1.25);
            }
        }else if(self.currency == "GBP"){
            if(to == "USD"){
                result.currency = "USD";
                result.amount = self.amount * 2;
            }else if(to == "EUR"){
                result.currency = "EUR";
                result.amount = self.amount * (3);
            }else{
                result.currency = "CAN";
                result.amount = Int(Double(self.amount) * 2.5);
            }
        }else if(self.currency == "EUR"){
            if(to == "GBP"){
                result.currency = "GBP";
                result.amount = self.amount / 3;
            }else if(to == "USD"){
                result.currency = "USD";
                result.amount = Int(Double(self.amount) * 2 / 3);
            }else{
                result.currency = "CAN";
                result.amount = Int(Double(self.amount) * 4 / 5);
            }
        }else{
            if(to == "GBP"){
                result.currency = "GBP";
                result.amount = Int(Double(self.amount) * 2 / 5);
            }else if(to == "EUR"){
                result.currency = "EUR";
                result.amount = Int(Double(self.amount) *  6 / 5);
            }else{
                result.currency = "USD";
                result.amount = Int(Double(self.amount) * 4 / 5);
            }
        }
        return result;
    }
    
    public func add(_ to: Money) -> Money {
        var result : Money = Money(amount: self.amount, currency: self.currency);
        if(to.currency != self.currency){
            result = convert(to.currency);
        }
        result.amount = result.amount + to.amount;
        return result;
    }
    
    public func subtract(_ from: Money) -> Money {
        var result : Money = Money(amount: self.amount, currency: self.currency);
        if(from.currency != self.currency){
            result = convert(from.currency);
        }
        result.amount = result.amount - from.amount;
        return result;
    }
}

////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible{
    fileprivate var title : String
    fileprivate var type : JobType
    public var description : String {
        switch type {
        case .Salary (let income):
            return "\(title) \(income)"
        case .Hourly(let income):
            return "\(title) \(income)"
        }
    }
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title;
        self.type = type;
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let hourlyIncome):
            if(hours == 0){
                return Int(hourlyIncome);
            }
            return Int(hourlyIncome * Double(hours));
        case .Salary(let yearlyIncome):
            return yearlyIncome;
        }
    }
    
    open func raise(_ amt : Double) {
        switch type {
        case .Hourly(let hourlyIncome):
            self.type = .Hourly(hourlyIncome + amt);
        case .Salary(let yearlyIncome):
            self.type = .Salary(yearlyIncome + Int(amt));
        }
    }
}

////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible{
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    public var description : String {
        return "\(firstName) \(lastName) \(age)"
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job }
        set(value) {
            if(age < 16){
                _job = nil;
            }else{
                _job = value;
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse}
        set(value) {
            if(age < 18){
                _spouse = nil;
            }else{
                _spouse = value;
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String(describing: _job)) spouse:\(String(describing: _spouse))]";
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible{
    fileprivate var members : [Person] = []
    public var description : String {
        var result : String = "[";
        for member in members {
            result += member.description + ", ";
        }
        result+="]";
        return result;
    }
    public init(spouse1: Person, spouse2: Person) {
        if(spouse1._spouse != nil || spouse2._spouse != nil){
            return;
        }
        members.append(spouse1);
        members.append(spouse2);
        spouse1._spouse = spouse2;
        spouse2._spouse = spouse1;
    }
    
    open func haveChild(_ child: Person) -> Bool {
        members.append(child)
        return true;
    }
    
    open func householdIncome() -> Int {
        var sum : Int = 0;
        
        for var person: Person in members{
            if(person.job != nil){
                sum += (person.job?.calculateIncome(2000))!
            }
        }
        return sum;
    }
}
