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

    function startElection(bytes32 name, Proposal[] calldata proposals, uint modules, uint exponent) public {
        require(msg.sender == chairperson, "Has no right to create election");
        require(name != "", "Name must be specified");
        require(!elections[name].created, "Election already created");

        RSAPublicKey memory pKey = RSAPublicKey(modules, exponent);
        Election memory election = Election(name, proposals, pKey, true);
        elections[name] = election;
    }

    /**
     * @dev validate and store vote
     * @param signedBallot bas64 encoded json representation of signed ballot
     */
    function vote(string calldata signedBallot) public {
        //bas64 decode
        bytes memory decode = Base64.decode(signedBallot);
    }

}