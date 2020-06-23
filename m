Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F396C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A172078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592905998;
	bh=Hqyy7ujXEgNcz+CfIub8oI+E19TZ58vdz7XwApLbxg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fwqHhzlVBTluOmwcUX766bqC7CWoYosB3swWcVLPt9czm/d+Yek+t9ieHI6+h69rN
	 A5Q0Ai6TRSTCri6PLYj/tKywP2YJ4HqL/DPKtV2mgkkaEE7SLIEW/D9eGIRHDOnqTw
	 sDPl4e07Oj6aC0NCmgtC1DZ3X239gbFTSUfvvaKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgFWJxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbgFWJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C4D20738;
        Tue, 23 Jun 2020 09:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905986;
        bh=Hqyy7ujXEgNcz+CfIub8oI+E19TZ58vdz7XwApLbxg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09o6Q7I5R94bs2NtW/UpFS9W8eUGWTzZQB8MKXha4b2MiKfDCF1qHduD/0sYav6lS
         3hWGrdXh/TvBeu1hGJTJ0nSvcrSZepfFEaKbiAYgyS+PhOq+Vl1UKi7AKynxoeIRRL
         1uaccXqwtcfSx1bDZavhthCU9MR6OqA2bFI4Bdog=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfbz-004C35-Rn; Tue, 23 Jun 2020 11:53:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/9] docs: dt: convert booting-without-of.txt to ReST format
Date:   Tue, 23 Jun 2020 11:52:54 +0200
Message-Id: <8dce14af13f66cb8393c21b58f0693e667a7045f.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm/booting.rst                 |   2 +-
 ...-without-of.txt => booting-without-of.rst} | 298 ++++++++++--------
 Documentation/devicetree/index.rst            |   1 +
 Documentation/translations/zh_CN/arm/Booting  |   2 +-
 4 files changed, 168 insertions(+), 135 deletions(-)
 rename Documentation/devicetree/{booting-without-of.txt => booting-without-of.rst} (90%)

diff --git a/Documentation/arm/booting.rst b/Documentation/arm/booting.rst
index 4babb6c6ae1e..a2263451dc2c 100644
--- a/Documentation/arm/booting.rst
+++ b/Documentation/arm/booting.rst
@@ -128,7 +128,7 @@ it.  The recommended placement is in the first 16KiB of RAM.
 
 The boot loader must load a device tree image (dtb) into system ram
 at a 64bit aligned address and initialize it with the boot data.  The
-dtb format is documented in Documentation/devicetree/booting-without-of.txt.
+dtb format is documented in Documentation/devicetree/booting-without-of.rst.
 The kernel will look for the dtb magic value of 0xd00dfeed at the dtb
 physical address to determine if a dtb has been passed instead of a
 tagged list.
diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.rst
similarity index 90%
rename from Documentation/devicetree/booting-without-of.txt
rename to Documentation/devicetree/booting-without-of.rst
index 4660ccee35a3..e9433350a20f 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.rst
@@ -1,15 +1,19 @@
-           Booting the Linux/ppc kernel without Open Firmware
-           --------------------------------------------------
-
-(c) 2005 Benjamin Herrenschmidt <benh at kernel.crashing.org>,
-    IBM Corp.
-(c) 2005 Becky Bruce <becky.bruce at freescale.com>,
-    Freescale Semiconductor, FSL SOC and 32-bit additions
-(c) 2006 MontaVista Software, Inc.
-    Flash chip node definition
-
-Table of Contents
-=================
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================================
+Booting the Linux/ppc kernel without Open Firmware
+==================================================
+
+Copyright (c) 2005 Benjamin Herrenschmidt <benh at kernel.crashing.org>,
+IBM Corp.
+
+Copyright (c) 2005 Becky Bruce <becky.bruce at freescale.com>,
+Freescale Semiconductor, FSL SOC and 32-bit additions
+
+Copyright (c) 2006 MontaVista Software, Inc.
+Flash chip node definition
+
+.. Table of Contents
 
   I - Introduction
     1) Entry point for arch/arm
@@ -61,15 +65,18 @@ Table of Contents
 Revision Information
 ====================
 
-   May 18, 2005: Rev 0.1 - Initial draft, no chapter III yet.
+   May 18, 2005: Rev 0.1
+			 - Initial draft, no chapter III yet.
 
-   May 19, 2005: Rev 0.2 - Add chapter III and bits & pieces here or
+   May 19, 2005: Rev 0.2
+			 - Add chapter III and bits & pieces here or
                            clarifies the fact that a lot of things are
                            optional, the kernel only requires a very
                            small device tree, though it is encouraged
                            to provide an as complete one as possible.
 
-   May 24, 2005: Rev 0.3 - Precise that DT block has to be in RAM
+   May 24, 2005: Rev 0.3
+			 - Precise that DT block has to be in RAM
 			 - Misc fixes
 			 - Define version 3 and new format version 16
 			   for the DT block (version 16 needs kernel
@@ -82,7 +89,8 @@ Revision Information
 			   "name" property is now automatically
 			   deduced from the unit name
 
-   June 1, 2005: Rev 0.4 - Correct confusion between OF_DT_END and
+   June 1, 2005: Rev 0.4
+			 - Correct confusion between OF_DT_END and
                            OF_DT_END_NODE in structure definition.
                          - Change version 16 format to always align
                            property data to 4 bytes. Since tokens are
@@ -115,7 +123,7 @@ Revision Information
 	- Compare FSL SOC use of PCI to standard and make sure no new
 	  node definition required.
 	- Add more information about node definitions for SOC devices
-  	  that currently have no standard, like the FSL CPM.
+	  that currently have no standard, like the FSL CPM.
 
 
 I - Introduction
@@ -260,7 +268,7 @@ it with special cases.
 
         b) create your main platform file as
         "arch/powerpc/platforms/myplatform/myboard_setup.c" and add it
-        to the Makefile under the condition of your CONFIG_
+        to the Makefile under the condition of your ``CONFIG_``
         option. This file will define a structure of type "ppc_md"
         containing the various callbacks that the generic code will
         use to get to your platform specific code
@@ -271,7 +279,7 @@ it with special cases.
   with classic Powerpc architectures.
 
 3) Entry point for arch/x86
--------------------------------
+---------------------------
 
   There is one single 32bit entry point to the kernel at code32_start,
   the decompressor (the real mode entry point goes to the same  32bit
@@ -280,9 +288,9 @@ it with special cases.
   Documentation/x86/boot.rst
   The physical pointer to the device-tree block (defined in chapter II)
   is passed via setup_data which requires at least boot protocol 2.09.
-  The type filed is defined as
+  The type filed is defined as::
 
-  #define SETUP_DTB                      2
+    #define SETUP_DTB                      2
 
   This device-tree is used as an extension to the "boot page". As such it
   does not parse / consider data which is already covered by the boot
@@ -354,9 +362,9 @@ the block to RAM before passing it to the kernel.
 
    The kernel is passed the physical address pointing to an area of memory
    that is roughly described in include/linux/of_fdt.h by the structure
-   boot_param_header:
+   boot_param_header:::
 
-struct boot_param_header {
+      struct boot_param_header {
         u32     magic;                  /* magic word OF_DT_HEADER */
         u32     totalsize;              /* total size of DT block */
         u32     off_dt_struct;          /* offset to structure */
@@ -374,19 +382,19 @@ struct boot_param_header {
 
         /* version 17 fields below */
         u32	size_dt_struct;		/* size of the DT structure block */
-};
+      };
 
-   Along with the constants:
+   Along with the constants::
 
-/* Definitions used by the flattened device tree */
-#define OF_DT_HEADER            0xd00dfeed      /* 4: version,
-						   4: total size */
-#define OF_DT_BEGIN_NODE        0x1             /* Start node: full name
-						   */
-#define OF_DT_END_NODE          0x2             /* End node */
-#define OF_DT_PROP              0x3             /* Property: name off,
-                                                   size, content */
-#define OF_DT_END               0x9
+    /* Definitions used by the flattened device tree */
+    #define OF_DT_HEADER            0xd00dfeed      /* 4: version,
+						    4: total size */
+    #define OF_DT_BEGIN_NODE        0x1             /* Start node: full name
+						    */
+    #define OF_DT_END_NODE          0x2             /* End node */
+    #define OF_DT_PROP              0x3             /* Property: name off,
+						    size, content */
+    #define OF_DT_END               0x9
 
    All values in this header are in big endian format, the various
    fields in this header are defined more precisely below. All
@@ -430,7 +438,7 @@ struct boot_param_header {
      way to avoid overriding critical things like, on Open Firmware
      capable machines, the RTAS instance, or on some pSeries, the TCE
      tables used for the iommu. Typically, the reserve map should
-     contain _at least_ this DT block itself (header,total_size). If
+     contain **at least** this DT block itself (header,total_size). If
      you are passing an initrd to the kernel, you should reserve it as
      well. You do not need to reserve the kernel image itself. The map
      should be 64-bit aligned.
@@ -485,7 +493,7 @@ struct boot_param_header {
 
    So the typical layout of a DT block (though the various parts don't
    need to be in that order) looks like this (addresses go from top to
-   bottom):
+   bottom)::
 
 
              ------------------------------
@@ -511,9 +519,9 @@ struct boot_param_header {
       |
       --- (base + totalsize)
 
-  (*) The alignment gaps are not necessarily present; their presence
-      and size are dependent on the various alignment requirements of
-      the individual data blocks.
+     (*) The alignment gaps are not necessarily present; their presence
+         and size are dependent on the various alignment requirements of
+         the individual data blocks.
 
 
 2) Device tree generalities
@@ -600,7 +608,7 @@ discussed in a later chapter. At this point, it is only meant to give
 you a idea of what a device-tree looks like. I have purposefully kept
 the "name" and "linux,phandle" properties which aren't necessary in
 order to give you a better idea of what the tree looks like in
-practice.
+practice::
 
   / o device-tree
       |- name = "device-tree"
@@ -650,6 +658,7 @@ properties and their content.
 
 
 3) Device tree "structure" block
+--------------------------------
 
 The structure of the device tree is a linearized tree structure. The
 "OF_DT_BEGIN_NODE" token starts a new node, and the "OF_DT_END_NODE"
@@ -666,12 +675,14 @@ Here's the basic structure of a single node:
        root node)
      * [align gap to next 4 bytes boundary]
      * for each property:
+
         * token OF_DT_PROP (that is 0x00000003)
         * 32-bit value of property value size in bytes (or 0 if no
           value)
         * 32-bit value of offset in string block of property name
         * property value data if any
         * [align gap to next 4 bytes boundary]
+
      * [child nodes if any]
      * token OF_DT_END_NODE (that is 0x00000002)
 
@@ -688,6 +699,7 @@ manipulating a flattened tree must take care to preserve this
 constraint.
 
 4) Device tree "strings" block
+------------------------------
 
 In order to save space, property names, which are generally redundant,
 are stored separately in the "strings" block. This block is simply the
@@ -700,15 +712,17 @@ strings block.
 III - Required content of the device tree
 =========================================
 
-WARNING: All "linux,*" properties defined in this document apply only
-to a flattened device-tree. If your platform uses a real
-implementation of Open Firmware or an implementation compatible with
-the Open Firmware client interface, those properties will be created
-by the trampoline code in the kernel's prom_init() file. For example,
-that's where you'll have to add code to detect your board model and
-set the platform number. However, when using the flattened device-tree
-entry point, there is no prom_init() pass, and thus you have to
-provide those properties yourself.
+.. Warning::
+
+   All ``linux,*`` properties defined in this document apply only
+   to a flattened device-tree. If your platform uses a real
+   implementation of Open Firmware or an implementation compatible with
+   the Open Firmware client interface, those properties will be created
+   by the trampoline code in the kernel's prom_init() file. For example,
+   that's where you'll have to add code to detect your board model and
+   set the platform number. However, when using the flattened device-tree
+   entry point, there is no prom_init() pass, and thus you have to
+   provide those properties yourself.
 
 
 1) Note about cells and address representation
@@ -769,7 +783,7 @@ addresses), all buses must contain a "ranges" property. If the
 "ranges" property is missing at a given level, it's assumed that
 translation isn't possible, i.e., the registers are not visible on the
 parent bus.  The format of the "ranges" property for a bus is a list
-of:
+of::
 
 	bus address, parent bus address, size
 
@@ -877,7 +891,7 @@ address which can extend beyond that limit.
 
   This node is the parent of all individual CPU nodes. It doesn't
   have any specific requirements, though it's generally good practice
-  to have at least:
+  to have at least::
 
                #address-cells = <00000001>
                #size-cells    = <00000000>
@@ -887,7 +901,7 @@ address which can extend beyond that limit.
   that format when reading the "reg" properties of a CPU node, see
   below
 
-  c) The /cpus/* nodes
+  c) The ``/cpus/*`` nodes
 
   So under /cpus, you are supposed to create a node for every CPU on
   the machine. There is no specific restriction on the name of the
@@ -903,21 +917,23 @@ address which can extend beyond that limit.
     - reg : This is the physical CPU number, it's a single 32-bit cell
       and is also used as-is as the unit number for constructing the
       unit name in the full path. For example, with 2 CPUs, you would
-      have the full path:
+      have the full path::
+
         /cpus/PowerPC,970FX@0
         /cpus/PowerPC,970FX@1
+
       (unit addresses do not require leading zeroes)
-    - d-cache-block-size : one cell, L1 data cache block size in bytes (*)
+    - d-cache-block-size : one cell, L1 data cache block size in bytes [#]_
     - i-cache-block-size : one cell, L1 instruction cache block size in
       bytes
     - d-cache-size : one cell, size of L1 data cache in bytes
     - i-cache-size : one cell, size of L1 instruction cache in bytes
 
-(*) The cache "block" size is the size on which the cache management
-instructions operate. Historically, this document used the cache
-"line" size here which is incorrect. The kernel will prefer the cache
-block size and will fallback to cache line size for backward
-compatibility.
+    .. [#] The cache "block" size is the size on which the cache management
+	   instructions operate. Historically, this document used the cache
+	   "line" size here which is incorrect. The kernel will prefer the cache
+	   block size and will fallback to cache line size for backward
+	   compatibility.
 
   Recommended properties:
 
@@ -963,10 +979,10 @@ compatibility.
       #address-cells and #size-cells of the root node. For example,
       with both of these properties being 2 like in the example given
       earlier, a 970 based machine with 6Gb of RAM could typically
-      have a "reg" property here that looks like:
+      have a "reg" property here that looks like::
 
-      00000000 00000000 00000000 80000000
-      00000001 00000000 00000001 00000000
+        00000000 00000000 00000000 80000000
+        00000001 00000000 00000001 00000000
 
       That is a range starting at 0 of 0x80000000 bytes and a range
       starting at 0x100000000 and of 0x100000000 bytes. You can see
@@ -1047,18 +1063,18 @@ compatibility.
       See 1) above for more details on defining #address-cells.
     - #size-cells : Size representation for "soc" devices
     - #interrupt-cells : Defines the width of cells used to represent
-       interrupts.  Typically this value is <2>, which includes a
-       32-bit number that represents the interrupt number, and a
-       32-bit number that represents the interrupt sense and level.
-       This field is only needed if the SOC contains an interrupt
-       controller.
+      interrupts.  Typically this value is <2>, which includes a
+      32-bit number that represents the interrupt number, and a
+      32-bit number that represents the interrupt sense and level.
+      This field is only needed if the SOC contains an interrupt
+      controller.
 
   The SOC node may contain child nodes for each SOC device that the
   platform uses.  Nodes should not be created for devices which exist
   on the SOC but are not used by a particular platform. See chapter VI
   for more information on how to specify devices that are part of a SOC.
 
-  Example SOC node for the MPC8540:
+  Example SOC node for the MPC8540::
 
 	soc8540@e0000000 {
 		#address-cells = <1>;
@@ -1079,31 +1095,33 @@ IV - "dtc", the device tree compiler
 dtc source code can be found at
 <http://git.jdl.com/gitweb/?p=dtc.git>
 
-WARNING: This version is still in early development stage; the
-resulting device-tree "blobs" have not yet been validated with the
-kernel. The current generated block lacks a useful reserve map (it will
-be fixed to generate an empty one, it's up to the bootloader to fill
-it up) among others. The error handling needs work, bugs are lurking,
-etc...
+.. Warning::
+
+   This version is still in early development stage; the
+   resulting device-tree "blobs" have not yet been validated with the
+   kernel. The current generated block lacks a useful reserve map (it will
+   be fixed to generate an empty one, it's up to the bootloader to fill
+   it up) among others. The error handling needs work, bugs are lurking,
+   etc...
 
 dtc basically takes a device-tree in a given format and outputs a
 device-tree in another format. The currently supported formats are:
 
-  Input formats:
-  -------------
+Input formats
+-------------
 
      - "dtb": "blob" format, that is a flattened device-tree block
        with
-        header all in a binary blob.
+       header all in a binary blob.
      - "dts": "source" format. This is a text file containing a
        "source" for a device-tree. The format is defined later in this
-        chapter.
+       chapter.
      - "fs" format. This is a representation equivalent to the
-        output of /proc/device-tree, that is nodes are directories and
-	properties are files
+       output of /proc/device-tree, that is nodes are directories and
+       properties are files
 
- Output formats:
- ---------------
+Output formats
+--------------
 
      - "dtb": "blob" format
      - "dts": "source" format
@@ -1113,7 +1131,7 @@ device-tree in another format. The currently supported formats are:
        assembly file exports some symbols that can be used.
 
 
-The syntax of the dtc tool is
+The syntax of the dtc tool is::
 
     dtc [-I <input-format>] [-O <output-format>]
         [-o output-filename] [-V output_version] input_filename
@@ -1127,43 +1145,45 @@ Additionally, dtc performs various sanity checks on the tree, like the
 uniqueness of linux, phandle properties, validity of strings, etc...
 
 The format of the .dts "source" file is "C" like, supports C and C++
-style comments.
+style comments::
 
-/ {
-}
+    / {
+    }
 
 The above is the "device-tree" definition. It's the only statement
 supported currently at the toplevel.
 
-/ {
-  property1 = "string_value";	/* define a property containing a 0
-                                 * terminated string
-				 */
+::
 
-  property2 = <0x1234abcd>;	/* define a property containing a
-                                 * numerical 32-bit value (hexadecimal)
-				 */
+  / {
+    property1 = "string_value";	   /* define a property containing a 0
+				    * terminated string
+				    */
 
-  property3 = <0x12345678 0x12345678 0xdeadbeef>;
-                                /* define a property containing 3
-                                 * numerical 32-bit values (cells) in
-                                 * hexadecimal
-				 */
-  property4 = [0x0a 0x0b 0x0c 0x0d 0xde 0xea 0xad 0xbe 0xef];
-                                /* define a property whose content is
-                                 * an arbitrary array of bytes
-                                 */
+    property2 = <0x1234abcd>;	   /* define a property containing a
+				    * numerical 32-bit value (hexadecimal)
+				    */
 
-  childnode@address {	/* define a child node named "childnode"
-                                 * whose unit name is "childnode at
-				 * address"
-                                 */
+    property3 = <0x12345678 0x12345678 0xdeadbeef>;
+				   /* define a property containing 3
+				    * numerical 32-bit values (cells) in
+				    * hexadecimal
+				    */
+    property4 = [0x0a 0x0b 0x0c 0x0d 0xde 0xea 0xad 0xbe 0xef];
+				   /* define a property whose content is
+				    * an arbitrary array of bytes
+				    */
 
-    childprop = "hello\n";      /* define a property "childprop" of
-                                 * childnode (in this case, a string)
-                                 */
-  };
-};
+    childnode@address {		   /* define a child node named "childnode"
+				    * whose unit name is "childnode at
+				    * address"
+				    */
+
+	childprop = "hello\n";	       /* define a property "childprop" of
+					* childnode (in this case, a string)
+					*/
+	};
+    };
 
 Nodes can contain other nodes etc... thus defining the hierarchical
 structure of the tree.
@@ -1322,7 +1342,7 @@ phandle of the parent node.
 
 If the interrupt-parent property is not defined for a node, its
 interrupt parent is assumed to be an ancestor in the node's
-_device tree_ hierarchy.
+*device tree* hierarchy.
 
 3) OpenPIC Interrupt Controllers
 --------------------------------
@@ -1334,10 +1354,12 @@ information.
 
 Sense and level information should be encoded as follows:
 
-	0 = low to high edge sensitive type enabled
-	1 = active low level sensitive type enabled
-	2 = active high level sensitive type enabled
-	3 = high to low edge sensitive type enabled
+	==  ========================================
+	0   low to high edge sensitive type enabled
+	1   active low level sensitive type enabled
+	2   active high level sensitive type enabled
+	3   high to low edge sensitive type enabled
+	==  ========================================
 
 4) ISA Interrupt Controllers
 ----------------------------
@@ -1350,13 +1372,15 @@ information.
 ISA PIC interrupt controllers should adhere to the ISA PIC
 encodings listed below:
 
-	0 =  active low level sensitive type enabled
-	1 =  active high level sensitive type enabled
-	2 =  high to low edge sensitive type enabled
-	3 =  low to high edge sensitive type enabled
+	==  ========================================
+	0   active low level sensitive type enabled
+	1   active high level sensitive type enabled
+	2   high to low edge sensitive type enabled
+	3   low to high edge sensitive type enabled
+	==  ========================================
 
 VIII - Specifying Device Power Management Information (sleep property)
-===================================================================
+======================================================================
 
 Devices on SOCs often have mechanisms for placing devices into low-power
 states that are decoupled from the devices' own register blocks.  Sometimes,
@@ -1387,6 +1411,7 @@ reasonably grouped in this manner, then create a virtual sleep controller
 sleep-map should wait until its necessity is demonstrated).
 
 IX - Specifying dma bus information
+===================================
 
 Some devices may have DMA memory range shifted relatively to the beginning of
 RAM, or even placed outside of kernel RAM. For example, the Keystone 2 SoC
@@ -1404,25 +1429,30 @@ coherent DMA operations. The "dma-coherent" property is intended to be used
 for identifying devices supported coherent DMA operations in DT.
 
 * DMA Bus master
+
 Optional property:
+
 - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
-	(child-bus-address, parent-bus-address, length). Each triplet specified
-	describes a contiguous DMA address range.
-	The dma-ranges property is used to describe the direct memory access (DMA)
-	structure of a memory-mapped bus whose device tree parent can be accessed
-	from DMA operations originating from the bus. It provides a means of
-	defining a mapping or translation between the physical address space of
-	the bus and the physical address space of the parent of the bus.
-	(for more information see the Devicetree Specification)
+  (child-bus-address, parent-bus-address, length). Each triplet specified
+  describes a contiguous DMA address range.
+  The dma-ranges property is used to describe the direct memory access (DMA)
+  structure of a memory-mapped bus whose device tree parent can be accessed
+  from DMA operations originating from the bus. It provides a means of
+  defining a mapping or translation between the physical address space of
+  the bus and the physical address space of the parent of the bus.
+  (for more information see the Devicetree Specification)
 
 * DMA Bus child
+
 Optional property:
+
 - dma-ranges: <empty> value. if present - It means that DMA addresses
-	translation has to be enabled for this device.
+  translation has to be enabled for this device.
 - dma-coherent: Present if dma operations are coherent
 
-Example:
-soc {
+Example::
+
+	soc {
 		compatible = "ti,keystone","simple-bus";
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
@@ -1435,11 +1465,13 @@ soc {
 			[...]
 			dma-coherent;
 		};
-};
+	};
 
 Appendix A - Sample SOC node for MPC8540
 ========================================
 
+::
+
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 54026763916d..d2a96e1af23e 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -15,3 +15,4 @@ Open Firmware and Device Tree
    overlay-notes
 
    bindings/index
+   booting-without-of
diff --git a/Documentation/translations/zh_CN/arm/Booting b/Documentation/translations/zh_CN/arm/Booting
index 562e9a2957e6..c3d26ce5f6de 100644
--- a/Documentation/translations/zh_CN/arm/Booting
+++ b/Documentation/translations/zh_CN/arm/Booting
@@ -124,7 +124,7 @@ bootloader 必须传递一个系统内存的位置和最小值，以及根文件
 
 bootloader 必须以 64bit 地址对齐的形式加载一个设备树映像(dtb)到系统
 RAM 中，并用启动数据初始化它。dtb 格式在文档
-Documentation/devicetree/booting-without-of.txt 中。内核将会在
+Documentation/devicetree/booting-without-of.rst 中。内核将会在
 dtb 物理地址处查找 dtb 魔数值（0xd00dfeed），以确定 dtb 是否已经代替
 标签列表被传递进来。
 
-- 
2.26.2

