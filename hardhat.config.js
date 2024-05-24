require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");


//import('hardhat/config').HardhatUserConfig;
module.exports = {
  solidity: "0.8.24",
  networks:{
    polygonAmoy:{
      accounts:[process.env.PRIVATE_KEY],
      url:process.env.POLYGON_AMOY_URL,
      gasPrice:"auto"
    }
  },
  etherscan: {
    apiKey: {
      polygonAmoy: process.env.POLYGON_AMOY_SCAN_KEY,
    },
    customChains: [
      {
        network: "polygonAmoy",
        chainId: 80002,
        urls: {
          apiURL: "https://api-amoy.polygonscan.com/api",
          browserURL: "https://amoy.polygonscan.com"
        },
      }
    ]
  }
};
