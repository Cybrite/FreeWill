
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;




contract VotingCampaign{
    address public manager;
    string public moto;
    mapping(address => bool) public voters;
    address[] public individuals;
    uint public voterCount;
    uint public positiveVoteCount;
    uint public negativeVoteCount;

    modifier Required(){
        require (voters[msg.sender]);
        _;
    }
  

    constructor(string memory about) {
        moto = about;
        manager = msg.sender;
    }

    function Register() public {
        require(!voters[msg.sender]);
       
        individuals.push(msg.sender);
        voters[msg.sender] = true;
        voterCount++;
    }

    function VoteUp() public Required{
        positiveVoteCount++;
        voters[msg.sender] = false;
    } // resets the mapping at same instance

    function VoteDown() public Required{
        negativeVoteCount++;
        voters[msg.sender] = false;
    } // resets the mapping at same instance

    function Reset() public{
        require(msg.sender == manager);

        delete individuals;
        delete positiveVoteCount;
        delete negativeVoteCount;
        delete voterCount;

    } // delete deletes everything expect mapping

     
    function getInidviduals() public view returns(address[] memory){
        return individuals;
    }

}