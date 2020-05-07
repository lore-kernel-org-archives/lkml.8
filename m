Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FDFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3601208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEGLJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:09:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGLJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:09:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77D7E37C0B2A99914725;
        Thu,  7 May 2020 19:09:33 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:09:26 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <davem@davemloft.net>, <yanaijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: tulip: de4x5: make PCI_signature() return void
Date:   Thu, 7 May 2020 19:08:47 +0800
Message-ID: <20200507110847.37940-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function always return 0 now, we can make it return void to
simplify the code. This fixes the following coccicheck warning:

drivers/net/ethernet/dec/tulip/de4x5.c:3908:11-17: Unneeded variable:
"status". Return "0" on line 3912

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index f16853c3c851..0ccd9994ad45 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -951,7 +951,7 @@ static void    reset_init_sia(struct net_device *dev, s32 sicr, s32 strr, s32 si
 static int     test_ans(struct net_device *dev, s32 irqs, s32 irq_mask, s32 msec);
 static int     test_tp(struct net_device *dev, s32 msec);
 static int     EISA_signature(char *name, struct device *device);
-static int     PCI_signature(char *name, struct de4x5_private *lp);
+static void    PCI_signature(char *name, struct de4x5_private *lp);
 static void    DevicePresent(struct net_device *dev, u_long iobase);
 static void    enet_addr_rst(u_long aprom_addr);
 static int     de4x5_bad_srom(struct de4x5_private *lp);
@@ -3902,14 +3902,14 @@ EISA_signature(char *name, struct device *device)
 /*
 ** Look for a particular board name in the PCI configuration space
 */
-static int
+static void
 PCI_signature(char *name, struct de4x5_private *lp)
 {
-    int i, status = 0, siglen = ARRAY_SIZE(de4x5_signatures);
+    int i, siglen = ARRAY_SIZE(de4x5_signatures);
 
     if (lp->chipset == DC21040) {
 	strcpy(name, "DE434/5");
-	return status;
+	return;
     } else {                           /* Search for a DEC name in the SROM */
 	int tmp = *((char *)&lp->srom + 19) * 3;
 	strncpy(name, (char *)&lp->srom + 26 + tmp, 8);
@@ -3935,8 +3935,6 @@ PCI_signature(char *name, struct de4x5_private *lp)
     } else if ((lp->chipset & ~0x00ff) == DC2114x) {
 	lp->useSROM = true;
     }
-
-    return status;
 }
 
 /*
-- 
2.21.1

