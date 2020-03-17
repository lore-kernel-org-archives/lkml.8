Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD139206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgCQG26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:28:58 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:25134 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCQG26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:28:58 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tddf54e8336ac1401c8808@ACLMS3.advantech.com.tw>;
 Tue, 17 Mar 2020 14:28:55 +0800
Received: from ADVANTECH.CORP (172.17.10.74) by taipei08.ADVANTECH.CORP
 (172.20.0.235) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Mar
 2020 14:28:54 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>
Subject: [v1,1/1] EDAC: (pnd2) Fix the log level for message "Failed to register device with error %d"
Date:   Tue, 17 Mar 2020 06:28:28 +0000
Message-ID: <20200317062828.18807-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.74]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

Fix the log level from "KERN_ERR" to "KERN_INFO" for message "Failed to
register device with error %d", since it is not the error message but
the information to notice the user.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
 drivers/edac/pnd2_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f772..f15d3b4 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
 
 	rc = pnd2_probe();
 	if (rc < 0) {
-		pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+		pnd2_printk(KERN_INFO,
+			    "Failed to register device with error %d.\n", rc);
 		return rc;
 	}
 
-- 
1.8.3.1

