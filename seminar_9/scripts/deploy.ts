import { ethers } from "hardhat";

async function main() {

  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account: ", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());
	
	const RPS = await ethers.getContractFactory("RockPaperScissors");
  const rps = await RPS.deploy();

  console.log("Created rps contract at address: ", rps.address);

  const RPSFacade = await ethers.getContractFactory("RockPaperScissorsFacade");
  const rpsFacade = await RPSFacade.deploy();

  console.log("Deployed rpsFacade contract at address: ", rpsFacade.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});