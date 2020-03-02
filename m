Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EEC3F2D6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68875246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137062;
	bh=4a4S5kJaWHjHlpmrc68T5FTFIJzAj8bHB4TYgHYD3iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CGQ/QeVQ0dbV/90BMzwjHcVyEnLJVOrqmQlglIEiyb8Yww94d83aKU6yLsUwN7njn
	 Qr4bUdlIMNrxhF+ExxEdhGujKioxXgEdovIMPg1roagSomS6jvALkrC29XRLhdtzkV
	 Tz0+NnYqurW7la3Ia8Ggkbp51UpZz41quau10Piw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCBIQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgCBIQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:20 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09237246BE;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=4a4S5kJaWHjHlpmrc68T5FTFIJzAj8bHB4TYgHYD3iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BK9G92s16vEfR45VhMUPyHZnzmSf9It/HN6BriRW01xol4KQp99jyDIArgmC9J6Gs
         VZaOSFginfpEiMuuSuK7Gnq1L5UigoN1BkDG991V1aGgIRDG2c7L7T1YtPxshQjiXz
         Dn3fgyTbf34ySeKvvvWc3sszVLvuALtPxdx/csLY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003xI-7p; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/42] docs: scsi: convert bfa.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:42 +0100
Message-Id: <6660d0f83ddae2ab8efb31c39f9c220fc132e9d4.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/scsi/{bfa.txt => bfa.rst} | 28 +++++++++++++++++--------
 Documentation/scsi/index.rst            |  1 +
 2 files changed, 20 insertions(+), 9 deletions(-)
 rename Documentation/scsi/{bfa.txt => bfa.rst} (72%)

diff --git a/Documentation/scsi/bfa.txt b/Documentation/scsi/bfa.rst
similarity index 72%
rename from Documentation/scsi/bfa.txt
rename to Documentation/scsi/bfa.rst
index 3cc4d80d6092..3abc0411857d 100644
--- a/Documentation/scsi/bfa.txt
+++ b/Documentation/scsi/bfa.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
 Linux driver for Brocade FC/FCOE adapters
-
+=========================================
 
 Supported Hardware
 ------------------
@@ -7,8 +10,9 @@ Supported Hardware
 bfa 3.0.2.2 driver supports all Brocade FC/FCOE adapters. Below is a list of
 adapter models with corresponding PCIIDs.
 
-	PCIID		  	Model
-
+	===================	===========================================
+	PCIID			Model
+	===================	===========================================
 	1657:0013:1657:0014	425 4Gbps dual port FC HBA
 	1657:0013:1657:0014	825 8Gbps PCIe dual port FC HBA
 	1657:0013:103c:1742	HP 82B 8Gbps PCIedual port FC HBA
@@ -26,6 +30,7 @@ adapter models with corresponding PCIIDs.
 
 	1657:0022:1657:0024	1860 16Gbps FC HBA
 	1657:0022:1657:0022	1860 10Gbps CNA - FCOE
+	===================	===========================================
 
 
 Firmware download
@@ -37,9 +42,11 @@ http://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
 
 and then click following respective util package link:
 
-	Version			Link
-
+	=========	=======================================================
+	Version		Link
+	=========	=======================================================
 	v3.0.0.0	Linux Adapter Firmware package for RHEL 6.2, SLES 11SP2
+	=========	=======================================================
 
 
 Configuration & Management utility download
@@ -52,9 +59,11 @@ http://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
 
 and then click following respective util package link
 
-	Version			Link
-
+	=========	=======================================================
+	Version		Link
+	=========	=======================================================
 	v3.0.2.0	Linux Adapter Firmware package for RHEL 6.2, SLES 11SP2
+	=========	=======================================================
 
 
 Documentation
@@ -69,10 +78,11 @@ http://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
 and use the following inbox and out-of-box driver version mapping to find
 the corresponding documentation:
 
+	=============		==================
 	Inbox Version		Out-of-box Version
-
+	=============		==================
 	v3.0.2.2		v3.0.0.0
-
+	=============		==================
 
 Support
 -------
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index c0b66763515f..1e37227f3536 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -13,5 +13,6 @@ Linux SCSI Subsystem
    aha152x
    aic79xx
    aic7xxx
+   bfa
 
    scsi_transport_srp/figures
-- 
2.21.1

