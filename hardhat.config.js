require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.22",
  networks:{
    goerli:{
      url: 'QUICKNODE_API_URL',
      accounts: ['PRIVATE_GOERLI_ACCOUNT_KEY'],
    },
  },
};
