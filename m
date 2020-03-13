Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DCE206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgCMIrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:47:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgCMIrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:47:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45FAC149D649E8748D21;
        Fri, 13 Mar 2020 16:47:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Mar 2020 16:47:06 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] irqchip/gic-v4: Fix non-stick page size error for setup GITS_BASER
Date:   Fri, 13 Mar 2020 16:46:35 +0800
Message-ID: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nianyao Tang <tangnianyao@huawei.com>

There is an error when ITS is probed if hw GITS_BASER<2>
only supports psz=SZ_16K while GITS_BASER<1> only supports psz=SZ_4K.
In its_alloc_tables, it has updated GITS_BASER<1>.psz and uses
psz=SZ_4K for setup GITS_BASER<2>, and would fail in writing
GITS_BASER<2>.psz=SZ_4K. 4K PAGE is the smallest and shall stop retry
for other page sizes.

That latter GITS_BASER<n>.psz is larger than former, will lead
to similar error.

[    0.000000] ITS@0x0000000660000000: Virtual CPUs doesn't stick: ba1f0824404004ff ba1f0824404005ff
[    0.000000] ITS@0x0000000660000000: failed probing (-6)
[    0.000000] ITS: No ITS available, not enabling LPIs

From GIC SPEC document, it's allowed for this implematation, the latter
GITS_BASER<n>.psz is larger than the former. 
Let's fix this error with following patch.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 83b1186..59bf8d6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2341,7 +2341,6 @@ static int its_alloc_tables(struct its_node *its)
 		}
 
 		/* Update settings which will be used for next BASERn */
-		psz = baser->psz;
 		cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
 		shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
 	}
-- 
1.9.1

