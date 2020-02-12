Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445392073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgBLKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:10:28 -0500
Received: from mx7.zte.com.cn ([202.103.147.169]:25060 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgBLKK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:10:28 -0500
X-Greylist: delayed 935 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 05:10:26 EST
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 24D58A4FEEEF343EF461;
        Wed, 12 Feb 2020 17:54:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 01C9sDsc032663;
        Wed, 12 Feb 2020 17:54:13 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020021217543472-2102565 ;
          Wed, 12 Feb 2020 17:54:34 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     sudeep.dutt@intel.com
Cc:     ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, vincent.whitchurch@axis.com,
        alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] misc: Use kzalloc() instead of kmalloc() with flag GFP_ZERO.
Date:   Wed, 12 Feb 2020 17:54:07 +0800
Message-Id: <1581501247-5479-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-02-12 17:54:34,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-02-12 17:54:16,
        Serialize complete at 2020-02-12 17:54:16
X-MAIL: mse-fl1.zte.com.cn 01C9sDsc032663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>

Use kzalloc instead of manually setting kmalloc
with flag GFP_ZERO since kzalloc sets allocated memory
to zero.

Change in v2:
     add indation

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/misc/mic/host/mic_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index 4f2d921..fb5b398 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -137,7 +137,7 @@ static void *__mic_dma_alloc(struct device *dev, size_t size,
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
 	dma_addr_t tmp;
-	void *va = kmalloc(size, gfp | __GFP_ZERO);
+	void *va = kzalloc(size, gfp);
 
 	if (va) {
 		tmp = mic_map_single(mdev, va, size);
-- 
1.9.1

