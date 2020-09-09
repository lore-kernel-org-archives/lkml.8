Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2074DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEE22166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgIIRDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:03:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730429AbgIIPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:46:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F39D713A618DF6ED4B13;
        Wed,  9 Sep 2020 21:44:13 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:44:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <gustavoars@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: host: ehci-sched: Remove ununsed function tt_start_uframe()
Date:   Wed, 9 Sep 2020 21:44:05 +0800
Message-ID: <20200909134405.34036-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b35c5009bbf6 ("USB: EHCI: create per-TT bandwidth tables")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/host/ehci-sched.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 847979f265b1..6dfb242f9a4b 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -307,26 +307,6 @@ static int __maybe_unused same_tt(struct usb_device *dev1,
 
 #ifdef CONFIG_USB_EHCI_TT_NEWSCHED
 
-/* Which uframe does the low/fullspeed transfer start in?
- *
- * The parameter is the mask of ssplits in "H-frame" terms
- * and this returns the transfer start uframe in "B-frame" terms,
- * which allows both to match, e.g. a ssplit in "H-frame" uframe 0
- * will cause a transfer in "B-frame" uframe 0.  "B-frames" lag
- * "H-frames" by 1 uframe.  See the EHCI spec sec 4.5 and figure 4.7.
- */
-static inline unsigned char tt_start_uframe(struct ehci_hcd *ehci, __hc32 mask)
-{
-	unsigned char smask = hc32_to_cpu(ehci, mask) & QH_SMASK;
-
-	if (!smask) {
-		ehci_err(ehci, "invalid empty smask!\n");
-		/* uframe 7 can't have bw so this will indicate failure */
-		return 7;
-	}
-	return ffs(smask) - 1;
-}
-
 static const unsigned char
 max_tt_usecs[] = { 125, 125, 125, 125, 125, 125, 30, 0 };
 
-- 
2.17.1


