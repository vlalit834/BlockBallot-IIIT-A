// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol";

// import "hardhart/console.sol"
contract Create {
    using Counters for Counters.Counter;
    Counters.Counter public voterID;
    Counters.Counter public candidateID;
    address public votingOrganizer;

    struct Candidate {
        uint256 candidateId;
        string age;
        string name;
        string image;
        uint256 voteCount;
        address candidateAddress;
        string ipfs;
    }

    event CandidateCreated(
        uint256 indexed candidateId,
        string age,
        string name,
        string image,
        uint256 voteCount,
        address candidateAddress,
        string ipfs
    );

    address[] public candidateAddresses;
    mapping(address => Candidate) public candidates;

    struct Voter {
        uint256 voterId;
        string voterName;
        string voterImage;
        address voterAddress;
        uint256 voterAllowed;
        bool voterVoted;
        uint256 voterVote;
        string voterIpfs;
    }

    event VoterCreated(
        uint256 voterId,
        string voterName,
        string voterImage,
        address voterAddress,
        uint256 voterAllowed,
        bool voterVoted,
        uint256 voterVote,
        string voterIpfs
    );

    mapping(address => Voter) public voters;
    address[] public votedVoters;
    address[] public votersAddress;

    constructor() {
        votingOrganizer = msg.sender;
    }

    function setCandidate(
        address _address,
        string memory _age,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "Only organizer can set candidate"
        );

        candidateID.increment();
        uint256 idNumber = candidateID.current();

        Candidate storage candidate = candidates[_address];
        candidate.age = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate.candidateAddress = _address;
        candidate.ipfs = _ipfs;

        candidateAddresses.push(_address);
        emit CandidateCreated(
            idNumber,
            _age,
            _name,
            _image,
            candidate.voteCount,
            _address,
            _ipfs
        );
    }

    function getCandidate() public view returns (address[] memory) {
        return candidateAddresses;
    }

    function getCandidateLength() public view returns (uint256) {
        return candidateAddresses.length;
    }

    function getCandidateData(address _address)
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            string memory,
            uint256,
            string memory,
            address
        )
    {
        return (
            candidates[_address].age,
            candidates[_address].name,
            candidates[_address].candidateId,
            candidates[_address].image,
            candidates[_address].voteCount,
            candidates[_address].ipfs,
            candidates[_address].candidateAddress
        );
    }

    function voterRight(
        address _address,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "Only organizer can create voter"
        );
        voterID.increment();
        uint256 idNumber = voterID.current();
        Voter storage voter = voters[_address];

        require(voter.voterAllowed == 0, "Already has rights"); // CHANGED: added error message

        voter.voterAllowed = 1;
        voter.voterName = _name;
        voter.voterImage = _image;
        voter.voterAddress = _address;
        voter.voterId = idNumber; // CHANGED: fixed typo, assigned to voterId
        voter.voterVote = 1000; // CHANGED: fixed typo, field is voterVote
        voter.voterVoted = false; // CHANGED: fixed typo, field is voterVoted
        voter.voterIpfs = _ipfs; // CHANGED: fixed typo, field is voterIpfs

        votersAddress.push(_address);
        emit VoterCreated(
            idNumber,
            _name,
            _image,
            _address,
            voter.voterAllowed, // CHANGED: fixed typo, field is voterAllowed
            voter.voterVoted, // CHANGED: fixed typo, field is voterVoted
            voter.voterVote, // CHANGED: fixed typo, field is voterVote
            _ipfs
        );
    }

    function vote(address _cadiadteAddress, uint256 _candidateVoteId) external {
        Voter storage voter = voters[msg.sender];
        require(!voter.voterVoted, "You have already voted"); // CHANGED: fixed typo in field and message
        require(voter.voterAllowed != 0, "You have no right to vote"); // CHANGED: clarified message

        voter.voterVoted = true; // CHANGED: fixed typo, field is voterVoted
        voter.voterVote = _candidateVoteId; // CHANGED: fixed typo, field is voterVote
        votedVoters.push(msg.sender);
        candidates[_cadiadteAddress].voteCount += voter.voterAllowed; // CHANGED: fixed typo, field is voterAllowed
    }

    function getVoterLength() public view returns (uint256) {
        return votersAddress.length;
    }

    function getVoterdata(address _address)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            address,
            string memory,
            uint256,
            bool
        )
    {
        return (
            voters[_address].voterId,
            voters[_address].voterName,
            voters[_address].voterImage,
            voters[_address].voterAddress,
            voters[_address].voterIpfs,
            voters[_address].voterAllowed,
            voters[_address].voterVoted
        );
    }

    function getVotedVoterList() public view returns (address[] memory) {
        return votedVoters;
    }

    function getVoterList() public view returns (address[] memory) {
        return votersAddress;
    }
}
