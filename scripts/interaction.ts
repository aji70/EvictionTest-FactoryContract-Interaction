import { ethers } from "hardhat";

// TRANSCATION HARSH = 0x7a19b5895b7a8eeec0f3e50f2203aaa430608070e9c0827e41f5505981624219
const main = async () => {
  const MedicationReminder = await ethers.getContractFactory(
    "MedicationReminderFactory"
  );
  const medicationReminder = MedicationReminder.attach(
    "0xBd4d5FEa1B2dFC905DD718556DF454A74009a02d"
  );

  const createReminder = await medicationReminder.createMedicationReminder();

  await createReminder.wait();

  const GetReminderContract = await medicationReminder.getUserContracts();

  //   await GetReminderContract.wait();

  console.log(GetReminderContract);
};

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
