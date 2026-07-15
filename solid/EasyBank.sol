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

    function withdraw() public payable  {
        balances[msg.sender] -= msg.value;
    } 
}