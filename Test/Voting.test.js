const assert = require("assert");
const ganache = require("ganache");
const { Web3 } = require("web3");
const web3 = new Web3(ganache.provider());
 
const compiledFactory = require("../build/pollFactory.json");
const compiledCampaign = require("../build/VotingCampaign.json");
 
let accounts;
let pollFactory;
let campaignAddress;
let Votingcampaign;
 
beforeEach(async () => {
  accounts = await web3.eth.getAccounts();
 
  pollFactory = await new web3.eth.Contract(compiledFactory.abi)
    .deploy({ data: compiledFactory.evm.bytecode.object })
    .send({ from: accounts[0], gas: "1400000" });
 
  await pollFactory.methods.createPoll("Testing").send({
    from: accounts[0],
    gas: "1000000",
  });
 
  [campaignAddress] = await pollFactory.methods.getDeployed().call();
  Votingcampaign = new web3.eth.Contract(compiledCampaign.abi, campaignAddress);
});
 
describe("VotingCampaigns", () => {
  it("deployes successfully", () => {
    assert.ok(pollFactory.options.address);
    // assert.ok(Votingcampaign.options.address);
  });
});
