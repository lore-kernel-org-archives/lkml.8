Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4B0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AAB246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137045;
	bh=XBwBhjITGcB44Pv8cMd8FxRV9Rl3IP3krKiqEf8u8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6Zg606o6ZZ1GZ2iJp9s89PnSyhYYtwgBQ4ssVdfXiqW70gLIg3NIJr8Kq4nTAB4b
	 TDc8Du4BwzooVJH30J57BTjion7PrueSeWZH6gMHztON64pEK4uaLbLT5vwFnZHvAT
	 Mf+emxhRIwqQxkf0WfWoq6Pm4V6VK3GcoU5FE+78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCBIRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbgCBIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:24 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F1824701;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136980;
        bh=XBwBhjITGcB44Pv8cMd8FxRV9Rl3IP3krKiqEf8u8zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piFtujPaZvsVaxIo4ZsN08TXhynjR2iF0HzHvu0mXW6Lni6Dr87GQUgx/2PXdLGOU
         J4W66LtQi1v3108COxrSIZ1VeCLaIjpzcSGXcIYmg1xiHNWdgqM84DMPYobXgzPZMU
         DxaCtfQnZHlz06BEcaR27iLj05nHI2hGLSKeFFnE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFO-0003zj-1z; Mon, 02 Mar 2020 09:16:18 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 39/42] docs: scsi: convert tcm_qla2xxx.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:12 +0100
Message-Id: <de73fa02f38f67f54f22ef2842f9680c0b34434a.1583136624.git.mchehab+huawei@kernel.org>
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
 .../scsi/{tcm_qla2xxx.txt => tcm_qla2xxx.rst} | 26 ++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)
 rename Documentation/scsi/{tcm_qla2xxx.txt => tcm_qla2xxx.rst} (57%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 238dd0ac36a6..df005cb94f6b 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -43,5 +43,6 @@ Linux SCSI Subsystem
    st
    sym53c500_cs
    sym53c8xx_2
+   tcm_qla2xxx
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/tcm_qla2xxx.txt b/Documentation/scsi/tcm_qla2xxx.rst
similarity index 57%
rename from Documentation/scsi/tcm_qla2xxx.txt
rename to Documentation/scsi/tcm_qla2xxx.rst
index c3a670a25e2b..91bc1fcd369e 100644
--- a/Documentation/scsi/tcm_qla2xxx.txt
+++ b/Documentation/scsi/tcm_qla2xxx.rst
@@ -1,22 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+tcm_qla2xxx Driver Notes
+========================
+
 tcm_qla2xxx jam_host attribute
 ------------------------------
 There is now a new module endpoint atribute called jam_host
-attribute: jam_host: boolean=0/1
+attribute::
+
+	jam_host: boolean=0/1
+
 This attribute and accompanying code is only included if the
 Kconfig parameter TCM_QLA2XXX_DEBUG is set to Y
+
 By default this jammer code and functionality is disabled
 
 Use this attribute to control the discarding of SCSI commands to a
 selected host.
+
 This may be useful for testing error handling and simulating slow drain
 and other fabric issues.
 
 Setting a boolean of 1 for the jam_host attribute for a particular host
- will discard the commands for that host.
+will discard the commands for that host.
+
 Reset back to 0 to stop the jamming.
 
-Enable host 4 to be jammed
-echo 1 > /sys/kernel/config/target/qla2xxx/21:00:00:24:ff:27:8f:ae/tpgt_1/attrib/jam_host
+Enable host 4 to be jammed::
 
-Disable jamming on host 4
-echo 0 > /sys/kernel/config/target/qla2xxx/21:00:00:24:ff:27:8f:ae/tpgt_1/attrib/jam_host
+  echo 1 > /sys/kernel/config/target/qla2xxx/21:00:00:24:ff:27:8f:ae/tpgt_1/attrib/jam_host
+
+Disable jamming on host 4::
+
+  echo 0 > /sys/kernel/config/target/qla2xxx/21:00:00:24:ff:27:8f:ae/tpgt_1/attrib/jam_host
-- 
2.21.1

