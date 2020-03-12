Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9C1C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 03:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FB320734
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 03:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgCLDVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:21:08 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51504 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgCLDVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:21:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TsLZZKv_1583983257;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TsLZZKv_1583983257)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Mar 2020 11:21:05 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        luanshi <zhangliguang@linux.alibaba.com>
Subject: [PATCH] irqchip/gic-v3: Move irq_domain_update_bus_token to after checking for NULL domain
Date:   Thu, 12 Mar 2020 11:20:55 +0800
Message-Id: <1583983255-44115-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_domain_update_bus_token should be called after checking for NULL
domain.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c1f7af9..8e5dd96 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1581,7 +1581,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
-	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
 	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
@@ -1592,6 +1591,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		goto out_free;
 	}
 
+	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
+
 	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
 	pr_info("Distributor has %sRange Selector support\n",
 		gic_data.has_rss ? "" : "no ");
-- 
1.8.3.1

