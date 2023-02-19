import { ethers } from "hardhat";

async function main() {
  const [owner, owner2] = await ethers.getSigners();
 // console.log(await ethers.getSigners());
  const admin = [owner.address,owner2.address,"0xfd182E53C17BD167ABa87592C5ef6414D25bb9B4"];
  //const [myOwn1, myOwn2, myOwn3, myOwn4] = await ethers.getSigners();
  //const myAdmins = [myOwn1.address, myOwn2.address, myOwn3.address, myOwn4.address];

  const CloneMultiSig = await ethers.getContractFactory("cloneMultiSig");
  //console.log(await ethers.getContractFactory("cloneMultiSig"));
  const cloneMultiSig = await CloneMultiSig.deploy();
  await cloneMultiSig.deployed();
  
  console.log(`Multisig Address is ${cloneMultiSig.address}`);
  //console.log(addr1.address, addr2.address, owner.address);

  const newMultisig = await cloneMultiSig.createMultiSig(admin);
  let event = await newMultisig.wait();
  console.log(event);
  let newChild = event.events[0].args[0];
  console.log(newChild);

  //////////////////////////////////////////////////

  const childMultisig = await ethers.getContractAt("IMultisig", newChild);
  const addresses = await childMultisig.returnAdmins();
  console.log(addresses);

  await childMultisig.addAdmin("0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb");
  await childMultisig.connect(owner2).addAdmin("0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb");

  const addressesNew = await childMultisig.returnAdmins();
  console.log(addressesNew);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});