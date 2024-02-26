// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MedicationReminder {
    struct Medication {
        uint id;
        string name;
        uint dosage;
        uint frequency; // in seconds
        uint lastTakenAt; // timestamp
    }

    mapping(uint => Medication) public medications;
    uint public medicationsCount;

    event MedicationAdded(uint indexed id, string name, uint dosage, uint frequency);
    event MedicationTaken(uint indexed id, uint timestamp);

    constructor() {
        medicationsCount = 0;
    }

    function addMedication(string memory _name, uint _dosage, uint _frequency) public {
        medicationsCount++;
        medications[medicationsCount] = Medication(medicationsCount, _name, _dosage, _frequency, 0);
        emit MedicationAdded(medicationsCount, _name, _dosage, _frequency);
    }

    function takeMedication(uint _id) public {
        require(_id > 0 && _id <= medicationsCount, "Invalid medication ID.");

        Medication storage med = medications[_id];
        require(block.timestamp - med.lastTakenAt >= med.frequency, "Medication can only be taken after the specified frequency.");

        med.lastTakenAt = block.timestamp;
        emit MedicationTaken(_id, block.timestamp);
    }

    function getMedication(uint _id) public view returns (string memory, uint, uint, uint) {
        require(_id > 0 && _id <= medicationsCount, "Invalid medication ID.");

        Medication storage med = medications[_id];
        return (med.name, med.dosage, med.frequency, med.lastTakenAt);
    }
}



contract MedicationReminderFactory {
    mapping(address => address[]) public userContracts;

    event MedicationReminderCreated(address indexed owner, address indexed contractAddress);

    function createMedicationReminder() public {
        MedicationReminder newContract = new MedicationReminder();
        userContracts[msg.sender].push(address(newContract));
        emit MedicationReminderCreated(msg.sender, address(newContract));
    }

    function getUserContracts() public view returns (address[] memory) {
        return userContracts[msg.sender];
    }
}
