Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911142070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgE3HcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:32:01 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:38198 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgE3HcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:32:01 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 0F7408FC64E834DD7286;
        Sat, 30 May 2020 15:31:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 04U7VsXs099484;
        Sat, 30 May 2020 15:31:54 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020053015323842-3751241 ;
          Sat, 30 May 2020 15:32:38 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     sudeep.dutt@intel.com
Cc:     ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH v2] misc: mic: Remove the error message as the call will print it
Date:   Sat, 30 May 2020 15:34:01 +0800
Message-Id: <1590824041-36500-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-30 15:32:38,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-30 15:32:00,
        Serialize complete at 2020-05-30 15:32:00
X-MAIL: mse-fl1.zte.com.cn 04U7VsXs099484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

The message should just be dropped as the call will print the failure
message anyway.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
changes in v2: remove the message instead of changing it.

 drivers/misc/mic/host/mic_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
index be0784f..ea46085 100644
--- a/drivers/misc/mic/host/mic_main.c
+++ b/drivers/misc/mic/host/mic_main.c
@@ -164,7 +164,6 @@ static int mic_probe(struct pci_dev *pdev,
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
 	if (!mdev) {
 		rc = -ENOMEM;
-		dev_err(&pdev->dev, "mdev kmalloc failed rc %d\n", rc);
 		goto mdev_alloc_fail;
 	}
 	mdev->id = ida_simple_get(&g_mic_ida, 0, MIC_MAX_NUM_DEVS, GFP_KERNEL);
-- 
2.9.5

