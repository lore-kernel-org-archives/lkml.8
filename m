Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C122C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEDD246C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137153;
	bh=2McQRtYZ+HSM4VsIstHnjM6JtSpkSFvG8RiBiZEorzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hh/ApKpgEYPmcDnwXvprWkHHK0H0yFg/qI1DgXYF+bYqeCIe7UmKXXbW994bNc2e+
	 UKwlGQYKO0UHirw/Zg4pXH2v5fyOv2QFF7df+whzQusEXPpxtczWVFAUFlwTyw0j5H
	 2LJnVWVr6Zg2GX9pdrkwkkfk5PeUsAvK4y8bm0Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCBITL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbgCBIQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:20 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CD0246C7;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=2McQRtYZ+HSM4VsIstHnjM6JtSpkSFvG8RiBiZEorzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndWbLqoE69WGK6FXi41Ia6LIbJWDiORZnkVxnrDHfORpxqDUbINdj3xbWVtOHdfGN
         CYDHdBvAkOIx4Q7gJ6Qohqs398zgI+6wDybIQUvC5YEanM553EX10GfWOJXGQexiYg
         LY+QcuRyHB9E+LLp3VtrTRNrfRP7CTsAZ0yNYYWo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003xW-AO; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/42] docs: scsi: convert cxgb3i.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:45 +0100
Message-Id: <0708b62b6ec4f0dddc581e412bb02ba6476f4523.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/scsi/{cxgb3i.txt => cxgb3i.rst} | 22 ++++++++++++-------
 Documentation/scsi/index.rst                  |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)
 rename Documentation/scsi/{cxgb3i.txt => cxgb3i.rst} (86%)

diff --git a/Documentation/scsi/cxgb3i.txt b/Documentation/scsi/cxgb3i.rst
similarity index 86%
rename from Documentation/scsi/cxgb3i.txt
rename to Documentation/scsi/cxgb3i.rst
index 7ac8032ee9b2..e01f18fbfa9f 100644
--- a/Documentation/scsi/cxgb3i.txt
+++ b/Documentation/scsi/cxgb3i.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
 Chelsio S3 iSCSI Driver for Linux
+=================================
 
 Introduction
 ============
@@ -49,7 +53,8 @@ The following steps need to be taken to accelerates the open-iscsi initiator:
 
    The cxgb3i module registers a new transport class "cxgb3i" with open-iscsi.
 
-   * in the case of recompiling the kernel, the cxgb3i selection is located at
+   * in the case of recompiling the kernel, the cxgb3i selection is located at::
+
 	Device Drivers
 		SCSI device support --->
 			[*] SCSI low-level drivers  --->
@@ -58,25 +63,26 @@ The following steps need to be taken to accelerates the open-iscsi initiator:
 2. Create an interface file located under /etc/iscsi/ifaces/ for the new
    transport class "cxgb3i".
 
-   The content of the file should be in the following format:
+   The content of the file should be in the following format::
+
 	iface.transport_name = cxgb3i
 	iface.net_ifacename = <ethX>
 	iface.ipaddress = <iscsi ip address>
 
    * if iface.ipaddress is specified, <iscsi ip address> needs to be either the
-	same as the ethX's ip address or an address on the same subnet. Make
-	sure the ip address is unique in the network.
+     same as the ethX's ip address or an address on the same subnet. Make
+     sure the ip address is unique in the network.
 
 3. edit /etc/iscsi/iscsid.conf
    The default setting for MaxRecvDataSegmentLength (131072) is too big;
-   replace with a value no bigger than 15360 (for example 8192):
+   replace with a value no bigger than 15360 (for example 8192)::
 
 	node.conn[0].iscsi.MaxRecvDataSegmentLength = 8192
 
    * The login would fail for a normal session if MaxRecvDataSegmentLength is
-	too big.  A error message in the format of
-	"cxgb3i: ERR! MaxRecvSegmentLength <X> too big. Need to be <= <Y>."
-	would be logged to dmesg.
+     too big.  A error message in the format of
+     "cxgb3i: ERR! MaxRecvSegmentLength <X> too big. Need to be <= <Y>."
+     would be logged to dmesg.
 
 4. To direct open-iscsi traffic to go through cxgb3i's accelerated path,
    "-I <iface file name>" option needs to be specified with most of the
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 6bb2428c1d56..3809213b83da 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -16,5 +16,6 @@ Linux SCSI Subsystem
    bfa
    bnx2fc
    BusLogic
+   cxgb3i
 
    scsi_transport_srp/figures
-- 
2.21.1

