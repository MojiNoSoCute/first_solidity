// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Lottery {
    address public manager;
    address [] public players;
    uint public winnerIndex;         // for testing
    uint public totalParticipant;    // for testing
    address public winnerPlayer;     // for testing

    constructor() {
        manager = msg.sender;

    }


    function enter() payable public {
        require(msg.value >= 0.001 ether, "Please enter more than 0.01 Ether");
        players.push(msg.sender);
    }

    function pickWinner()  public {
        require(msg.sender == manager, "ONLY manager");
        uint index = random() % players.length;
        winnerIndex = index;  // for testing
        (bool success,) = players[index].call{value: (address(this).balance)}("");
        require(success, "Transfer failed");
         winnerPlayer = players[index];
         totalParticipant = players.length;    
         players = new address [](0);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players)));

    }
}