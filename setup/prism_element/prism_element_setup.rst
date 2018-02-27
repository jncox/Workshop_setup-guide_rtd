-------------------
Configuring Prism Element
-------------------

Overview
+++++++++++++++++

In this guide we will configure Prism Element for the HPOC you have checked out. This includes the Storage Containers, User VM Network(s), Image Service, Authentication & Roles.


Requirements
.................

* AOS 5.5.x (or higher)
* AHV (for 5.5)
* Using 1 HPOC (If using more then one, do the same on both)


Connectivity & HPOC Info:
.................

We will use the following Info:

- **IP** - Cluster IP
- **Username** - admin
- **Password** - Password received
- **HPOC Subnet** - 10.21.XX.0
- *Subnet Mask** - 255.255.255.128
- **Gateway** - 10.21.XX.1
- **DNS Servers** - 10.21.253.10,10.21.253.11

**Example (From HPOC Automation Email):**

.. code-block:: bash

	Cluster IP: https://10.21.93.37:9440/console/#login

	Position: 1 SVM IP: 10.21.93.29 Hypervisor IP: 10.21.93.25 IPMI IP: 10.21.93.33
	Position: 2 SVM IP: 10.21.93.30 Hypervisor IP: 10.21.93.26 IPMI IP: 10.21.93.34
	Position: 3 SVM IP: 10.21.93.31 Hypervisor IP: 10.21.93.27 IPMI IP: 10.21.93.35
	Position: 4 SVM IP: 10.21.93.32 Hypervisor IP: 10.21.93.28 IPMI IP: 10.21.93.36


	LOGIN CREDENTIALS

	Prism UI Credentials: admin/Password
	CVM Credentials: nutanix/Password
	AHV Host Credentials: root/Password


	CLUSTER CREATION DETAILS

	Number of Initial Nodes: 3
	AOS Version: 5.5
	Hypervisor Version: AHV 20170830.58 (5.5)


	NETWORK INFORMATION

	Subnet Mask: 255.255.255.128
	Gateway: 10.21.9.31
	Nameserver IP: 10.21.253.10

Configure Prism Element for Workshop
+++++++++++++++++

Start by logging in and accepting the EULA.

UI Settings
.................

Change Session Timeout Values

In **Prism Central**, click :fa:`cog` **>  UI Settings**

Fill out the following fields and click **Save**:

- **Session Timeout for Current User** - 30 minutes
- **Default Session Timeout for all Users** - 2 hours
- **Session Timeout override** - Allow unlimited

Configure Data Services IP
.................

Select the Cluster in the upper left-hand corner

Fill out the following fields and click **Save**:

- **ISCSI Data Services IP** - 10.21.XX.38

Configure Storage Containers
.................

In **Prism > Storage**, click ** Storage**, then click **Table**

Delete the "default-container-xxxxx"

Create a new Storage Container called "Bootcamp"

Setup user VM network
.................

In **Prism > VM**, click ** VM**, then click **Table**

Click **Network Config**
Click **User VM Interfaces**

Click **Create Network**

Fill out the following fields and click **Save**:

- **Name** - bootcamp
- **VLAN ID** - 0
- **Enable IP Address Management** - Checked
- **Network IP Address / Prefix Length** - 10.x.x.0/25
- **Gateway** - 10.21.XX.1
- **DNS Servers** - 10.21.253.10,10.21.253.11
- **Domain Search** - nutanixdc.local
- **Domain name** - nutanixdc.local
- **TFT Server** - empty
- **Boot File** - empty
- **Create Pool** - 10.21.XX.50-10.21.XX.120
- **Override DHCP Server** - unchecked                 |

Image Configuration
.................

Verify Image Configurations has what you need for your Workshop

In **Prism Central**, click :fa:`cog` **> Image Configuration**

Depending on what you selected when reserving your HPOC you will see a CentOS7 Image & Windows 2012r2 Image

You may also see a VM for each already deployed. You can decide if you want to use them or delete them.

If you need upload any other ISOs or Images now is a good time to do so

Setup Authentication and Role Mapping
.................

**Note:** Setup & Configure a Domain Controller before completing this section.

In **Prism Central**, click :fa:`cog` **> Authentication**

Click **New Directory**

Fill out the following fields and click **Save**:

- **Directory Type** - Active Directory
- **Name** - Bootcamp
- **Domain** - bootcamp.local
- **Directory URL** - ldap://10.21.XX.40             |
- **Service Account Name** - administrator@bootcamp.local
- **Service Account Password** - HPOC Password

Click on the yellow ! next to **Bootcamp**

Click on the **Click Here** to go to the Role Mapping screen

Click **New Mapping**

Fill out the following fields and click **Save**:

- **Directory** - Bootcamp
- **LDAP Type** - group
- **Role** - Cluster Admin
- **Values** - Bootcamp Users

Close the Role Mapping and Authentication windows

Log out of Prism Element

Log in as **user01@bootcamp.local** using the password configured in the *add-user.csv* file.

**Note:** If you are able to log in then you have completed Prism Element and AD setup
