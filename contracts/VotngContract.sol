// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzepplin/contract/utils/Counter.sol"
import "hardhart/console.sol" 

contract Create{
    using Counter for Counter.Counter;
    Counter.Counter public _voterID;
    Counter.Counter public _candidateID;
    address public votingOrganizer;

    //CANDIDATE FOR VOTING
    struct Candiadate{
        uint256 candidateID;
        string age;
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs;
    }

    event CandiadateCreate(
        uint256 indexed candidateID,
        string age,
        string name,
        string image,
        uint256 voteCount,
        address _address,
        string ipfs
    )


    address[] public andidateAddress;

    mapping(address=>Candiadate)pubilc candidates;

    
}