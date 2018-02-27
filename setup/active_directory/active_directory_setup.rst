-------------------
Setup & Configure Windows Active Directory
-------------------

Overview
++++++++

In this guide we will setup a Windows Domain Controller, and configure Active Directory Domain Services. We will also create 20 users and a bootcamp users group for them.


Connectivity Instructions:
.................

We will use the following Info:

- **AD/DC1 VM IP** - 10.21.XX.40
- **Username** - admin
- **Password** - HPOC Password

Deploying Windows 2012R2 Server
++++++++

In this next section will deploy and/or configure the Windows 2012 Server

.. Note:: You can do either of these depending on if you want to build from scratch or use the one deployed by the HPOC system.

Deploying Windows 2012R2 Server from scratch
.................

Do this step if you are deploying from a Widows 2012R2 ISO

In **Prism > VM**, click ** VM**, then click **Table**

Click **+ Create VM**

Fill out the following fields and click **Save**:

- **Name** - DC1
- **Description** - bootcamp.local Domain Controller
- **VCPU(S)** - 2
- **Cores** - 1
- **Memory** - 4GiB
- **Disks** - **+ Add New Disk**
- **CD-ROM (From Image Service)** - W2K12R2 ISO
- **Disk** - 80gig Disk on Bootcamp Storage Container
- **2nd CD-ROM (From Image Service)** - VirtIO drivers 1.0.1 ISO
- **Network** - Primary

Now Power on the **DC1** VM

Use the HPOC password as the Administrator password

.. Note:: Remember to select all 3 drivers from VirtIO disk when you are at the "Select Install Disk" section.

Using Pre-Deployed Windows 2012R2 Server
.................

Do this step if you are using the Pre-Deployed Windows 2012R2 VM
(These Images are deployed if you select Windows VMs during HPOC Reservation Process)

In **Prism > VM**, click ** VM**, then click **Table**

Select the **Windows 2012 VM** and click **Update**

Change the following fields and click **Save**:

- **Name** - DC1
- **Description** - bootcamp.local Domain Controller
- **VCPU(S)** - 2
- **Cores** - 1
- **Memory** - 4GiB
- **Network** - Primary
- **Delete Rx-Automation-Network**

Now Power on the **DC1** VM

Use the HPOC password as the Administrator password

Configuring Windows Server Settings
++++++++

In This step we will run the **AutoSetupAD** script to configure AD

Create Directory & Download Scripts
.................

Log into the DC VM

Create **c:\\scripts** directory

Download **AutoSetupAD** & **add-users** (see below) to **c:\\scripts**

:download:`AutoSetupAD <scripts/AutoSetupAD.ps1>`

:download:`add-users <scripts/add-users.csv>`

Run AutoSetupAD Script
.................

Open PowerShell shell

Navigate to c:\Scripts

.. code-block:: bash

	./AutoSetupAD.ps1

Input the answers to the questions asked

Server will reboot, after it comes back launch script again.

Script will install AD Role, and configure the domain.

Server will reboot a second time, after it comes back launch script again (last time).

Server will create the **Bootcamp Users** group, and the 20 users.
