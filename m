Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A11C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01341221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgIJVWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:22:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731001AbgIJOYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79844F2DCA6CBF645C48;
        Thu, 10 Sep 2020 22:06:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:06:14 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <thomas@winischhofer.net>, <b.zolnierkie@samsung.com>,
        <yanaijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] video: fbdev: sis: remove unneeded semicolon
Date:   Thu, 10 Sep 2020 22:05:36 +0800
Message-ID: <20200910140536.1191150-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:

drivers/video/fbdev/sis/sis_accel.h:143:72-73: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:144:72-73: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:145:72-73: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:273:75-76: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:274:75-76: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:275:73-74: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:276:75-76: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/sis/sis_accel.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_accel.h b/drivers/video/fbdev/sis/sis_accel.h
index c3dfd2a20cf9..98d209658662 100644
--- a/drivers/video/fbdev/sis/sis_accel.h
+++ b/drivers/video/fbdev/sis/sis_accel.h
@@ -140,9 +140,9 @@
 
 #define SiS300Idle \
   { \
-  	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){}; \
-  	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){}; \
-  	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){}; \
+	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){} \
+	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){} \
+	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){} \
   	CmdQueLen = MMIO_IN16(ivideo->mmio_vbase, 0x8240); \
   }
 /* (do three times, because 2D engine seems quite unsure about whether or not it's idle) */
@@ -270,10 +270,10 @@
 
 #define SiS310Idle \
   { \
-  	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
-  	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
-	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
-  	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
   	CmdQueLen = 0; \
   }
 
-- 
2.25.4

