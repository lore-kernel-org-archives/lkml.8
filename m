Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1751C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B252468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137057;
	bh=aPFhGQiNbY9NE+xS+194iu0qMlLBO4+2ynIr21JV2uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FybWy4mx/mdKXZJjgrX8xV/KpJjnE6x60x2jEZV3HcNW8wmsJ2vEnZBdevobWy+sR
	 g0Z3OvpFQETRN0NBY7seRFsiiqYTuYFl9W8a7naGrZphpsskJSNc3a+MW02s1xYTvw
	 ki4H6p2sD6iph9damaakucsX5yKJQtTD3E6+lw4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCBIRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgCBIQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:23 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74D124706;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136980;
        bh=aPFhGQiNbY9NE+xS+194iu0qMlLBO4+2ynIr21JV2uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xtW2UnueyCepl2oS0Vtd/stXdrzaTs23IulgdyIOHwGWknPyVlLDjJBa34dS8lcEY
         FWLs2TfYIKjkpNKi50cLDgdb/2aLmCF5B8F4Tw//XRJUx9WzcJ0f2Ezn/y8fjkUCWB
         lMp6QQXhnTb+oTuy99mPStVlT8BGI3Bbxgr8ICWs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFO-0003zs-3X; Mon, 02 Mar 2020 09:16:18 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 41/42] docs: scsi: convert wd719x.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:14 +0100
Message-Id: <23e5b13d810b7dd8126b126173999c02eac50e74.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/scsi/index.rst                  |  1 +
 Documentation/scsi/{wd719x.txt => wd719x.rst} | 23 +++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)
 rename Documentation/scsi/{wd719x.txt => wd719x.rst} (46%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 27720d145eff..260f1145431d 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -45,5 +45,6 @@ Linux SCSI Subsystem
    sym53c8xx_2
    tcm_qla2xxx
    ufs
+   wd719x
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/wd719x.txt b/Documentation/scsi/wd719x.rst
similarity index 46%
rename from Documentation/scsi/wd719x.txt
rename to Documentation/scsi/wd719x.rst
index 0816b0220238..a35015dfedd9 100644
--- a/Documentation/scsi/wd719x.txt
+++ b/Documentation/scsi/wd719x.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================================
 Driver for Western Digital WD7193, WD7197 and WD7296 SCSI cards
----------------------------------------------------------------
+===============================================================
 
 The card requires firmware that can be cut out of the Windows NT driver that
 can be downloaded from WD at:
@@ -9,13 +12,13 @@ There is no license anywhere in the file or on the page - so the firmware
 probably cannot be added to linux-firmware.
 
 This script downloads and extracts the firmware, creating wd719x-risc.bin and
-d719x-wcs.bin files. Put them in /lib/firmware/.
+d719x-wcs.bin files. Put them in /lib/firmware/::
 
-#!/bin/sh
-wget http://support.wdc.com/download/archive/pciscsi.exe
-lha xi pciscsi.exe pci-scsi.exe
-lha xi pci-scsi.exe nt/wd7296a.sys
-rm pci-scsi.exe
-dd if=wd7296a.sys of=wd719x-risc.bin bs=1 skip=5760 count=14336
-dd if=wd7296a.sys of=wd719x-wcs.bin bs=1 skip=20096 count=514
-rm wd7296a.sys
+	#!/bin/sh
+	wget http://support.wdc.com/download/archive/pciscsi.exe
+	lha xi pciscsi.exe pci-scsi.exe
+	lha xi pci-scsi.exe nt/wd7296a.sys
+	rm pci-scsi.exe
+	dd if=wd7296a.sys of=wd719x-risc.bin bs=1 skip=5760 count=14336
+	dd if=wd7296a.sys of=wd719x-wcs.bin bs=1 skip=20096 count=514
+	rm wd7296a.sys
-- 
2.21.1

