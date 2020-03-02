Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D44C3F2D5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184D2468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137129;
	bh=2ystwVh1h2eU6vurRedIUhhyG4BGvNNF9noJpwOCuJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJCThdVEsbl4wf/4OCz5djNVrr0zv9YiENmhH5k+IzHfEdztu69gN5eysinOuSN5G
	 LRM5Fk/PNkoJjS34mLpT1BZnhcF4jbMRQTz66NbmGg5topxPymM5nRwe/ATAIywJ5s
	 rYIpuxqu7J3pwEfNxhaeh2k6ZkPWo2AKsuA9dRmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCBISo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:18:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgCBIQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:21 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56241246DE;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=2ystwVh1h2eU6vurRedIUhhyG4BGvNNF9noJpwOCuJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRkpokPuX+U1d8fA5kDkGJp+0v37w2ntFUv/0eT0rx/Ko0SOXlbDMPHEPtMr7mhKO
         qOgwSU8buBEAM51ScROP2g946QBPC/su2j1TtKw2Aco9GC3zIRL+Uhup1I/XUEtN3b
         ZF6vghx9aSp7Vbql/WKvKMVxNTBqEgb1VsCIdVKM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003y0-Fy; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        HighPoint Linux Team <linux@highpoint-tech.com>
Subject: [PATCH 18/42] docs: scsi: convert hptiop.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:51 +0100
Message-Id: <d189a339bb360b7b397914ee3ddeb75d9a7fd788.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/{hptiop.txt => hptiop.rst} | 45 ++++++++++++++++---
 Documentation/scsi/index.rst                  |  1 +
 MAINTAINERS                                   |  2 +-
 3 files changed, 40 insertions(+), 8 deletions(-)
 rename Documentation/scsi/{hptiop.txt => hptiop.rst} (78%)

diff --git a/Documentation/scsi/hptiop.txt b/Documentation/scsi/hptiop.rst
similarity index 78%
rename from Documentation/scsi/hptiop.txt
rename to Documentation/scsi/hptiop.rst
index 12ecfd308e55..23ae7ae36971 100644
--- a/Documentation/scsi/hptiop.txt
+++ b/Documentation/scsi/hptiop.rst
@@ -1,15 +1,25 @@
-HIGHPOINT ROCKETRAID 3xxx/4xxx ADAPTER DRIVER (hptiop)
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+======================================================
+Highpoint RocketRAID 3xxx/4xxx Adapter Driver (hptiop)
+======================================================
 
 Controller Register Map
--------------------------
+-----------------------
 
-For RR44xx Intel IOP based adapters, the controller IOP is accessed via PCI BAR0 and BAR2:
+For RR44xx Intel IOP based adapters, the controller IOP is accessed via PCI BAR0 and BAR2
 
+     ============== ==================================
      BAR0 offset    Register
+     ============== ==================================
             0x11C5C Link Interface IRQ Set
             0x11C60 Link Interface IRQ Clear
+     ============== ==================================
 
+     ============== ==================================
      BAR2 offset    Register
+     ============== ==================================
             0x10    Inbound Message Register 0
             0x14    Inbound Message Register 1
             0x18    Outbound Message Register 0
@@ -21,10 +31,13 @@ For RR44xx Intel IOP based adapters, the controller IOP is accessed via PCI BAR0
             0x34    Outbound Interrupt Mask Register
             0x40    Inbound Queue Port
             0x44    Outbound Queue Port
+     ============== ==================================
 
 For Intel IOP based adapters, the controller IOP is accessed via PCI BAR0:
 
+     ============== ==================================
      BAR0 offset    Register
+     ============== ==================================
             0x10    Inbound Message Register 0
             0x14    Inbound Message Register 1
             0x18    Outbound Message Register 0
@@ -36,16 +49,22 @@ For Intel IOP based adapters, the controller IOP is accessed via PCI BAR0:
             0x34    Outbound Interrupt Mask Register
             0x40    Inbound Queue Port
             0x44    Outbound Queue Port
+     ============== ==================================
 
 For Marvell not Frey IOP based adapters, the IOP is accessed via PCI BAR0 and BAR1:
 
+     ============== ==================================
      BAR0 offset    Register
+     ============== ==================================
          0x20400    Inbound Doorbell Register
          0x20404    Inbound Interrupt Mask Register
          0x20408    Outbound Doorbell Register
          0x2040C    Outbound Interrupt Mask Register
+     ============== ==================================
 
+     ============== ==================================
      BAR1 offset    Register
+     ============== ==================================
              0x0    Inbound Queue Head Pointer
              0x4    Inbound Queue Tail Pointer
              0x8    Outbound Queue Head Pointer
@@ -53,14 +72,20 @@ For Marvell not Frey IOP based adapters, the IOP is accessed via PCI BAR0 and BA
             0x10    Inbound Message Register
             0x14    Outbound Message Register
      0x40-0x1040    Inbound Queue
-   0x1040-0x2040    Outbound Queue
+     0x1040-0x2040  Outbound Queue
+     ============== ==================================
 
 For Marvell Frey IOP based adapters, the IOP is accessed via PCI BAR0 and BAR1:
 
+     ============== ==================================
      BAR0 offset    Register
+     ============== ==================================
              0x0    IOP configuration information.
+     ============== ==================================
 
+     ============== ===================================================
      BAR1 offset    Register
+     ============== ===================================================
           0x4000    Inbound List Base Address Low
           0x4004    Inbound List Base Address High
           0x4018    Inbound List Write Pointer
@@ -76,10 +101,11 @@ For Marvell Frey IOP based adapters, the IOP is accessed via PCI BAR0 and BAR1:
          0x10420    CPU to PCIe Function 0 Message A
          0x10480    CPU to PCIe Function 0 Doorbell
          0x10484    CPU to PCIe Function 0 Doorbell Enable
+     ============== ===================================================
 
 
 I/O Request Workflow of Not Marvell Frey
-------------------------------------------
+----------------------------------------
 
 All queued requests are handled via inbound/outbound queue port.
 A request packet can be allocated in either IOP or host memory.
@@ -124,7 +150,7 @@ of an inbound message.
 
 
 I/O Request Workflow of Marvell Frey
---------------------------------------
+------------------------------------
 
 All queued requests are handled via inbound/outbound list.
 
@@ -167,13 +193,17 @@ User-level Interface
 
 The driver exposes following sysfs attributes:
 
+     ==================   ===    ========================
      NAME                 R/W    Description
+     ==================   ===    ========================
      driver-version        R     driver version string
      firmware-version      R     firmware version string
+     ==================   ===    ========================
 
 
 -----------------------------------------------------------------------------
-Copyright (C) 2006-2012 HighPoint Technologies, Inc. All Rights Reserved.
+
+Copyright |copy| 2006-2012 HighPoint Technologies, Inc. All Rights Reserved.
 
   This file is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -181,4 +211,5 @@ Copyright (C) 2006-2012 HighPoint Technologies, Inc. All Rights Reserved.
   GNU General Public License for more details.
 
   linux@highpoint-tech.com
+
   http://www.highpoint-tech.com
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index b16f348bd31b..b13df9c1810a 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -22,5 +22,6 @@ Linux SCSI Subsystem
    FlashPoint
    g_NCR5380
    hpsa
+   hptiop
 
    scsi_transport_srp/figures
diff --git a/MAINTAINERS b/MAINTAINERS
index 39767eca07d9..e2bd7911baa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7545,7 +7545,7 @@ HIGHPOINT ROCKETRAID 3xxx RAID DRIVER
 M:	HighPoint Linux Team <linux@highpoint-tech.com>
 W:	http://www.highpoint-tech.com
 S:	Supported
-F:	Documentation/scsi/hptiop.txt
+F:	Documentation/scsi/hptiop.rst
 F:	drivers/scsi/hptiop.c
 
 HIPPI
-- 
2.21.1

