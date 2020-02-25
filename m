Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9DCC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195922176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBYJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:02:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729153AbgBYJC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:02:28 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1C7BB921633353B4CAA3;
        Tue, 25 Feb 2020 17:02:21 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 17:02:10 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH] irq-gic-v3-its: fix access width for gicr_syncr
Date:   Tue, 25 Feb 2020 17:00:23 +0800
Message-ID: <20200225090023.28020-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICR_SYNCR is a 32bit register, so it is better to access it with
32bit access width, though we have not seen any real problem.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>

---
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 65a11257d220..5c6790e3bfbf 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1321,7 +1321,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 
 static void wait_for_syncr(void __iomem *rdbase)
 {
-	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
+	while (readl_relaxed(rdbase + GICR_SYNCR) & 1)
 		cpu_relax();
 }
 
-- 
2.19.1

