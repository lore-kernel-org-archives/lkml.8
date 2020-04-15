Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB73C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8069E2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961424;
	bh=6GT3w41hn966DMyFfp0vsF/LFh19lPhK+l5rxKUUk5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C+64qlRKlugO8DHpmvAGVW96GNc8KTo9o0FqsA0Ger0UH30E7+rSO4cTDLsvWm4II
	 Oru4Y+OBYu458wBznDdEYh3rUoDEQd6hWy0ktMulTuUfbg/5g0Hm/ydeE/ZdfynQde
	 iTBe4T1q9nvie30n7LwHPmFd9YxuLokuLVnzIeNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636598AbgDOOgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394095AbgDOOdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:07 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8177221F6;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961172;
        bh=6GT3w41hn966DMyFfp0vsF/LFh19lPhK+l5rxKUUk5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slDrz/GqaVbF6kU/Xe8zRxwajE+AZVpN0x36xM3BMtH5XVS74kWwRCNie59CMMBmR
         e1d9caRv16rejnN1s4hAp481415EZvjek0tCuvKQMqRSEhAAZ3jhIt3pj8hXcFhtW8
         sHPgKVlVRO6HRC0pdOdZqolficq9JS9vnDQncZgE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5u-006kQA-5d; Wed, 15 Apr 2020 16:32:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 31/34] docs: filesystems: convert sysfs-pci.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:44 +0200
Message-Id: <07b7cf662d3552f78c01c096b4845121113a581d.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../{sysfs-pci.txt => sysfs-pci.rst}          | 23 ++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)
 rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (92%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 6c5c312b8188..34d5f53931e7 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -36,6 +36,7 @@ algorithms work.
    quota
    seq_file
    sharedsubtree
+   sysfs-pci
 
    automount-support
 
diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.rst
similarity index 92%
rename from Documentation/filesystems/sysfs-pci.txt
rename to Documentation/filesystems/sysfs-pci.rst
index 06f1d64c6f70..a265f3e2cc80 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.rst
@@ -1,8 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
 Accessing PCI device resources through sysfs
---------------------------------------------
+============================================
 
 sysfs, usually mounted at /sys, provides access to PCI resources on platforms
-that support it.  For example, a given bus might look like this:
+that support it.  For example, a given bus might look like this::
 
      /sys/devices/pci0000:17
      |-- 0000:17:00.0
@@ -30,8 +33,9 @@ This bus contains a single function device in slot 0.  The domain and bus
 numbers are reproduced for convenience.  Under the device directory are several
 files, each with their own function.
 
+       =================== =====================================================
        file		   function
-       ----		   --------
+       =================== =====================================================
        class		   PCI class (ascii, ro)
        config		   PCI config space (binary, rw)
        device		   PCI device (ascii, ro)
@@ -40,13 +44,16 @@ files, each with their own function.
        local_cpus	   nearby CPU mask (cpumask, ro)
        remove		   remove device from kernel's list (ascii, wo)
        resource		   PCI resource host addresses (ascii, ro)
-       resource0..N	   PCI resource N, if present (binary, mmap, rw[1])
+       resource0..N	   PCI resource N, if present (binary, mmap, rw\ [1]_)
        resource0_wc..N_wc  PCI WC map resource N, if prefetchable (binary, mmap)
        revision		   PCI revision (ascii, ro)
        rom		   PCI ROM resource, if present (binary, ro)
        subsystem_device	   PCI subsystem device (ascii, ro)
        subsystem_vendor	   PCI subsystem vendor (ascii, ro)
        vendor		   PCI vendor (ascii, ro)
+       =================== =====================================================
+
+::
 
   ro - read only file
   rw - file is readable and writable
@@ -56,7 +63,7 @@ files, each with their own function.
   binary - file contains binary data
   cpumask - file contains a cpumask type
 
-[1] rw for RESOURCE_IO (I/O port) regions only
+.. [1] rw for RESOURCE_IO (I/O port) regions only
 
 The read only files are informational, writes to them will be ignored, with
 the exception of the 'rom' file.  Writable files can be used to perform
@@ -67,11 +74,11 @@ don't support mmapping of certain resources, so be sure to check the return
 value from any attempted mmap.  The most notable of these are I/O port
 resources, which also provide read/write access.
 
-The 'enable' file provides a counter that indicates how many times the device 
+The 'enable' file provides a counter that indicates how many times the device
 has been enabled.  If the 'enable' file currently returns '4', and a '1' is
 echoed into it, it will then return '5'.  Echoing a '0' into it will decrease
 the count.  Even when it returns to 0, though, some of the initialisation
-may not be reversed.  
+may not be reversed.
 
 The 'rom' file is special in that it provides read-only access to the device's
 ROM file, if available.  It's disabled by default, however, so applications
@@ -93,7 +100,7 @@ Accessing legacy resources through sysfs
 
 Legacy I/O port and ISA memory resources are also provided in sysfs if the
 underlying platform supports them.  They're located in the PCI class hierarchy,
-e.g.
+e.g.::
 
 	/sys/class/pci_bus/0000:17/
 	|-- bridge -> ../../../devices/pci0000:17
-- 
2.25.2

