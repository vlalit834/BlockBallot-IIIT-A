const hre = require("hardhat");
async function main() {
  const Lock = await hre.ethers.getcontractFactory("Lock");
  const lock = await Lock.deploy();
  await lock.deployed();
  console.log("lock", lock.address);
}
main().ctach((error) => {
  console.error(error);
  process.exitCode = 1;
});
