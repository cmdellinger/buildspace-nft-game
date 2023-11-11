const main = async () => {
    const gameContractFactory = await hre.ethers.getContractFactory('MyEpicGame');
    const gameContract = await gameContractFactory.deploy(
      ["Soldier Cat", "Kanpaw Panda", "Pepe", "Giant Doge"], // Names
      ["https://olive-spiritual-bison-836.mypinata.cloud/ipfs/Qme5mjshoXdB8SiWmsmFEGbJbPa98pLGqKpUC1AVGEbd5Y/NFT_game-cat_soldier.png", // Images
       "https://olive-spiritual-bison-836.mypinata.cloud/ipfs/Qme5mjshoXdB8SiWmsmFEGbJbPa98pLGqKpUC1AVGEbd5Y/NFT_game-panda.png", 
       "https://olive-spiritual-bison-836.mypinata.cloud/ipfs/Qme5mjshoXdB8SiWmsmFEGbJbPa98pLGqKpUC1AVGEbd5Y/NFT_game-pepe.png",
       "https://olive-spiritual-bison-836.mypinata.cloud/ipfs/Qme5mjshoXdB8SiWmsmFEGbJbPa98pLGqKpUC1AVGEbd5Y/NFT_game-giant_shiba_inu.png"],
      [200, 300, 100, 400],                    // HP values
      [50, 100, 25, 200],                      // Attack damage values
      [100, 10, 200, 50]                       // meme power
    );
    await gameContract.waitForDeployment();
    console.log("Contract deployed to:", await gameContract.getAddress());

    // mint an NFTs
    let txn;
    txn = await gameContract.mintCharacterNFT(0);
    await txn.wait();
    console.log("Minted NFT #1");
  
    txn = await gameContract.mintCharacterNFT(1);
    await txn.wait();
    console.log("Minted NFT #2");
  
    txn = await gameContract.mintCharacterNFT(2);
    await txn.wait();
    console.log("Minted NFT #3");
  
    txn = await gameContract.mintCharacterNFT(3);
    await txn.wait();
    console.log("Minted NFT #4");
  
    console.log("Done deploying and minting!");
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();