// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ComplicatedBank {
    mapping(address => uint) public balances;
    address[] accounts;
    address public owner;
    uint rate = 3; 

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner.");
        _;
    }

    function getBalance() public view returns (uint){
        return balances[msg.sender];
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insuffient money to withdraw!!!");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdraw failed!!");
    }

    function getSystemBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    function calculateInterest(address _user) public view onlyOwner returns(uint) {
        uint interest = balances[_user] * rate/100;
        return interest;
    }
}