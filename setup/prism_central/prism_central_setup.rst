-------------------
Configuring Basic Prism Central
-------------------

Overview
+++++++++++++++++

In this guide we will configure Prism Central for the HPOC you have checked out. This includes SSP and Calm (Apps).

Requirements
.................

1. AOS 5.5.x (or higher)
2. AHV (for 5.5)

Connectivity Instructions:
.................

We will use the following Info:

- **Prism Central IP** - 10.21.XX.39
- **Username** - admin
- **Password** - *HPOC Password*

Configure Prism Central for Workshop
+++++++++++++++++

We will start by installing prism Central.  Users must be logged in as "admin" to configure Prism Central (PC).

Install Prism Central
.................

Click on **Register or create new** on the Prism Central Widget (On the main Cluster page)

Click on **Deploy** in the "I want to deploy a new Prims Central instance" box

If 5.5.x shows under available version, click **Download**.

If it does not show up, the you will need to click on **upload the Prism Central binary** (The tar & json files should be available on POCFS/HPOC-AFS)

Click on **Install** next to 5.5.x

Fill out the following fields and click **Deploy**:

- **VM Name** - PC
- **Container** - Bootcamp
- **VM Sizing** - Small
- **AHV Network** - Primary
- **IP Address** - 10.21.XX.39

**Note:** Once the Prism Central deployment task finishes, move on

Configure Prism Central for Workshop
+++++++++++++++++

Start by logging in and accepting the EULA.

UI Settings
.................

In s separate browser tab, got to https://10.x.x.39:9440

Log in with the following credentials:

- **Username** - admin
- **Password** - Nutanix/4u

Change **Password** to the following:

- **Password** - *HPOC Password*

Log in with the following:

- **Username** - admin
- **Password** - *HPOC Password*

Accept the EULA

UI Settings
.................

Change Session Timeout Values

In **Prism Central**, click :fa:`cog` **>  UI Settings**

Fill out the following fields and click **Save**:

- **Session Timeout for Current User** - 30 minutes
- **Default Session Timeout for all Users** - 2 hours
- **Session Timeout override** - Allow unlimited

Register Prism Element with Prism Central
+++++++++++++++++

In **Prism Element**, click on **Register or create new** on the Prism Central Widget (On the main Cluster page)

Click on **Connect** in the "I already have a Prism Central instance deployed" box

Click **Next**

Fill out the following fields and click **Connect**:

- **Prism Central IP** - 10.21.XX.39
- **Username** - admin
- **Password** - *HPOC Password*

You should now see **OK** in the Prism Central Widget (On the main Cluster page)

Setup Authentication and Role Mapping
.................

**Note:** Setup & Configure a Domain Controller before completing this section.

In **Prism Central**, click :fa:`cog` **> Authentication**

Click **New Directory**

Fill out the following fields and click **Save**:

- **Directory Type** - Active Directory
- **Name** - NTNXLAB
- **Domain** - ntnxlab.local
- **Directory URL** - ldap://10.21.XX.40
- **Service Account Name** - administrator@ntnxlab.local
- **Service Account Password** - nutanix/4u

Click on the yellow ! next to **NTNXLAB**

Click on the **Click Here** to go to the Role Mapping screen

Click **New Mapping**

Fill out the following fields and click **Save**:

- **Directory** - NTNXLAB
- **LDAP Type** - user
- **Role** - Cluster Admin
- **Values** - administrator@ntnxlab.local

Close the Role Mapping and Authentication windows

Log out of Prism Central

Log in as **user01@bootcamp.local** using the password configured in the *add-user.csv* file.

**Note:** If you are able to log in then you have completed Prism Central Authentication Setup
