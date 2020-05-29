Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D933C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BE62078C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438334AbgE2BOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:14:52 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:52066 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438256AbgE2BOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:14:50 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 21:14:49 EDT
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 57CA1D65B285BB26CA41;
        Fri, 29 May 2020 08:59:19 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 04T0xBPF058301;
        Fri, 29 May 2020 08:59:11 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020052908594550-3735716 ;
          Fri, 29 May 2020 08:59:45 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     sudeep.dutt@intel.com
Cc:     ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] misc: mic: Replace kmalloc with kzalloc in the error message
Date:   Fri, 29 May 2020 09:01:21 +0800
Message-Id: <1590714081-15574-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-29 08:59:45,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-29 08:59:16,
        Serialize complete at 2020-05-29 08:59:16
X-MAIL: mse-fl1.zte.com.cn 04T0xBPF058301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Use kzalloc instead of kmalloc in the error message according to
the previous kzalloc() call.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 drivers/misc/mic/host/mic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
index be0784f..8296f31 100644
--- a/drivers/misc/mic/host/mic_main.c
+++ b/drivers/misc/mic/host/mic_main.c
@@ -164,7 +164,7 @@ static int mic_probe(struct pci_dev *pdev,
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
 	if (!mdev) {
 		rc = -ENOMEM;
-		dev_err(&pdev->dev, "mdev kmalloc failed rc %d\n", rc);
+		dev_err(&pdev->dev, "mdev kzalloc failed rc %d\n", rc);
 		goto mdev_alloc_fail;
 	}
 	mdev->id = ida_simple_get(&g_mic_ida, 0, MIC_MAX_NUM_DEVS, GFP_KERNEL);
-- 
2.9.5

