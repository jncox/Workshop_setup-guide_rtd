.. _example-lab1:

-------------------
Lab 1 - Style Guide
-------------------

Overview
++++++++

Here is where we provide a high level description of what the user will be doing during this module. In this module we'll look at basic rules for text, figures, and notes.

Text and Figures
++++++++++++++++

Label sections appropriately, see existing labs if further guidance is required. Use consistent markup for titles, subtitles, sub-subtitles, etc. The markup in the example can serve as a guide but other characters can be used within a given workshop, as long as they are consistent. Other than lab titles (that need to follow a certain linear progression) avoid numbering steps.

Below are examples of standards we should strive to maintain in writing lab guides. *Italics* is used to indicate when information of values external to the lab guide are referenced. **Bold** is used to reference words and phrases in the UI. **Bold** should also be used to highlight the key name in lists containing key/value pairs as shown below. The **>** character is used to show a reasonable progression of clicks, such as traversing a drop down menu. When appropriate, try to consolidate short, simple tasks.

Actions should end with a period, or optionally with a colon as in the case of displaying a list of fields that need to be populated. Keep the language consistent: open, click/select, fill out, log in, and execute.

Use the **figure** directive to include images in your lab guide or appendix. Image files should not be included within the Git repository. Image files should be uploaded to the nutanixworkshops bucket in S3. Create a subdirectory in S3 that corresponds to the subdirectory for your workshop within the Git repository.

--------------------------------------

Open \https://<*NUTANIX-CLUSTER-IP*>:9440 in your browser to access Prism. Log in as a user with administrative priveleges.

.. figure:: http://s3.nutanixworkshops.com/templates/ahv_windows/1.png

Click **Network Config > User VM Interfaces > +Create Network**.

.. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab1/1.png

Select **Enable IP Address Management** and fill out the following fields:

- **Name** - VM VLAN
- **VLAN ID** - *Refer to your Environment Details Worksheet*
- **Network IP Address/Prefix Length** - *Refer to your Environment Details Worksheet*
- **Gateway IP Address** - *Refer to your Environment Details Worksheet*
- **Domain Name Servers** - *Refer to your Environment Details Worksheet*

.. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab1/2.png

Click **Submit > Save**.

Notes
+++++

Notes provide easily noticable interjections to lab instructions. Reasons to use a note include calling attention to a step that requires additional context or referencing external resources. Make sure to include a return before and after the note directive for it to render properly. **Please don't abuse notes.**

.. note:: Check out `this <http://openalea.gforge.inria.fr/doc/openalea/doc/_build/html/source/sphinx/rest_syntax.html>`_ cheat sheet for helpful documentation on formatting text, links, tables, etc. in Restructured Text.

Takeaways
+++++++++

- Here is where we summarize any key takeaways from the module
- Such as how a Nutanix feature used in the lab delivers value
- Or highlighting a differentiator
