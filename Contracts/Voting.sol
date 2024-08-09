// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract pollFactory{
    address payable[] public deployedPoll;

    function createPoll(string memory about) public {
        address newPoll = address( new VotingCampaign(about, msg.sender));

        deployedPoll.push(payable(newPoll));
    }

    function getDeployedPolls() public view returns(address payable[] memory){
        return deployedPoll;
    }
}




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
  

    constructor(string memory about, address creator) {
        moto = about;
        manager = creator;
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

        delete positiveVoteCount;
        delete negativeVoteCount;
        delete voterCount;

        for(uint i =0; i<individuals.length; i++){
            if(voters[individuals[i]] = true){
                voters[individuals[i]] = false;
            }
        }

        delete individuals;
    } // delete deletes everything & resets mapping

     
    function getInidviduals() public view returns(address[] memory){
        return individuals;
    }

}