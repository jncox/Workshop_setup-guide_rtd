-------------------
Xtract for DBs
-------------------

Overview
++++++++

In this exercise you will deploy, and use the Xtract tool to migrate a Database.

Deploy Xtract for DBs
+++++++++++++++++

In **Prism > VM**, click ** VM**, then click **Table**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb01.png

Click **+ Create VM**

Fill out the following fields and click **Save**:

- **Name** - Xtract-DB
- **Description** - Xtract for DBs
- **VCPU(S)** - 2
- **Cores** - 1
- **Memory** - 4GiB
- **Disks** - **+ Add New Disk**
- **Disk Image (From Image Service)** - Xtract-DB
- **Network** - Primary
- **IP Address** - 10.21.XX.43

Now Power on the **Xtract-DB** VM

When it completes it open a browser window to the **Xtract for DBs** Dashboard, https://10.21.XX.43

Login with the following credentials:

- **Username** - nutanix
- **Password** - nutanix/4u

 Fill in **Name**, **COmapny**, and **Job Title**, then **Accept** the EULA

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb02.png

Click **OK** when the **Nutanix Customer Experience Program** pops up

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb03.png

Create Project & Migrate Database with Xtract for DBs
+++++++++++++

In this portion of the lab we will create a new project in **Xtract-DB**, and migrate a MS SQL Server database.

Create New Migration Project
.................

Enter project name, and click **Create New Project**:

**Project Name** - Website DB

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb04.png



Migrate Database with Xtract for DBs
.................



Conclusions
+++++++++++

- A summary of key points from the lab
- Can include highlighting relevant value proposition
- Or key differentiators
