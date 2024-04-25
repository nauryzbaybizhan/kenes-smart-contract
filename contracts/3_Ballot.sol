// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import 'base64-sol/base64.sol';

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Ballot {

    struct Election {
        bytes32 name;
        Proposal[] proposals;
        RSAPublicKey publicKey;
        bool created;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    struct RSAPublicKey {
        uint modulus;
        uint exponent;
    }

    address public chairperson;

    mapping(bytes32 => Election) public elections;

    constructor() {
        chairperson = msg.sender;
    }

    function createElection(bytes32 name, Proposal[] calldata proposals, uint modules, uint exponent) public {
        require(msg.sender == chairperson, "Has no right to create election");
        require(name != "", "Name must be specified");
        require(!elections[name].created, "Election already created");

        for (uint i = 0; i < proposals.length; i++) {
            elections[name].proposals.push(proposals[i]);
        }
        elections[name].name = name;
        elections[name].publicKey = RSAPublicKey(modules, exponent);
        elections[name].created = true;
    }

    /**
     * @dev validate and store vote
     * @param signedBallot base64 encoded json representation of signed ballot
     */
    function vote(string calldata signedBallot) public {
        //bas64 decode
        bytes memory decode = Base64.decode(signedBallot);
        //read json
        //decrypt sign with pkey
        //hash payload
        //compare hashes
    }

    /**
     * @dev returns modulus and exponent of RSAPublicKey
     * @param electionName is the name of election
     */
    function getPKey(bytes32 electionName) view public returns(uint, uint) {
        uint modulus = elections[electionName].publicKey.modulus;
        uint exponent = elections[electionName].publicKey.exponent;
        return (modulus, exponent);
    }

}