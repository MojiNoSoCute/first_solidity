// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EasyBank {
    mapping(address => uint) public balances; 

    function getBalance() public view returns (uint){
        return balances[msg.sender];
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insuffient money to withdraw!!!");
        // balances[msg.sender] -= amount;
        balances[msg.sender] = balances[msg.sender] - amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdraw failed!!");
    } 
}