Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681EEC2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236BC21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKHNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:13:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgIKHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:13:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1DF03501A4B223675124;
        Fri, 11 Sep 2020 15:13:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Sep 2020 15:13:03 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <davem@davemloft.net>, <dan.j.williams@intel.com>,
        <dvhart@infradead.org>, <mchehab+samsung@kernel.org>,
        <gregkh@linuxfoundation.org>, <dsterba@suse.com>, <arnd@arndb.de>
CC:     <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] sbus: char: Remove meaningless jump label out_free
Date:   Fri, 11 Sep 2020 15:13:41 +0800
Message-ID: <20200911071341.101397-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 57a4a3d7f756 ("display7seg: Introduce the use of the managed
version of kzalloc"), The out_free jump label has nothing to do but goto
out. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/sbus/char/display7seg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index fad936eb845f..00e72b97d0b6 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -186,7 +186,7 @@ static int d7s_probe(struct platform_device *op)
 	p->regs = of_ioremap(&op->resource[0], 0, sizeof(u8), "d7s");
 	if (!p->regs) {
 		printk(KERN_ERR PFX "Cannot map chip registers\n");
-		goto out_free;
+		goto out;
 	}
 
 	err = misc_register(&d7s_miscdev);
@@ -228,8 +228,6 @@ static int d7s_probe(struct platform_device *op)
 
 out_iounmap:
 	of_iounmap(&op->resource[0], p->regs, sizeof(u8));
-
-out_free:
 	goto out;
 }
 
-- 
2.17.1

