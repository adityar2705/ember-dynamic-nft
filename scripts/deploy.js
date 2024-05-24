const {ethers} = require("hardhat");

//creating the main function to deploy our contract
async function main(){
    const EmberNft = await ethers.getContractFactory("Ember");
    const emberNft = await EmberNft.deploy();

    await emberNft.waitForDeployment();
    console.log("Ember Dynamic NFT deployed to : ",emberNft.target);
}

//run main with error handling
main().then(() => {
    process.exit(0);
}).catch((error) => {
    console.error(error);
    process.exit(1);
});