Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF9C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2015721532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIG7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:59:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbgIIG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:59:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 467553311BEC91ED1E7B;
        Wed,  9 Sep 2020 14:59:17 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 14:59:07 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 1/3] irqchip: dw-apb-ictl: prepare for support hierarchy irq domain
Date:   Wed, 9 Sep 2020 14:58:34 +0800
Message-ID: <20200909065836.2631-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200909065836.2631-1-thunder.leizhen@huawei.com>
References: <20200909065836.2631-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename some functions and variables in advance, to make the next patch
looks more clear. The details are as follows:
1. rename dw_apb_ictl_handler() to dw_apb_ictl_handle_irq_cascaded().
2. change (1 << hwirq) to BIT(hwirq).

In function dw_apb_ictl_init():
1. rename local variable irq to parent_irq.
2. add "const struct irq_domain_ops *domain_ops = &irq_generic_chip_ops",
   then replace &irq_generic_chip_ops in other places with domain_ops.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Haoyu Lv <lvhaoyu@huawei.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index e4550e9c810b..5458004242e9 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -26,7 +26,7 @@
 #define APB_INT_FINALSTATUS_H	0x34
 #define APB_INT_BASE_OFFSET	0x04
 
-static void dw_apb_ictl_handler(struct irq_desc *desc)
+static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -43,7 +43,7 @@ static void dw_apb_ictl_handler(struct irq_desc *desc)
 			u32 virq = irq_find_mapping(d, gc->irq_base + hwirq);
 
 			generic_handle_irq(virq);
-			stat &= ~(1 << hwirq);
+			stat &= ~BIT(hwirq);
 		}
 	}
 
@@ -73,12 +73,13 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
 	void __iomem *iobase;
-	int ret, nrirqs, irq, i;
+	int ret, nrirqs, parent_irq, i;
 	u32 reg;
+	const struct irq_domain_ops *domain_ops = &irq_generic_chip_ops;
 
 	/* Map the parent interrupt for the chained handler */
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0) {
+	parent_irq = irq_of_parse_and_map(np, 0);
+	if (parent_irq <= 0) {
 		pr_err("%pOF: unable to parse irq\n", np);
 		return -EINVAL;
 	}
@@ -120,8 +121,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	else
 		nrirqs = fls(readl_relaxed(iobase + APB_INT_ENABLE_L));
 
-	domain = irq_domain_add_linear(np, nrirqs,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_add_linear(np, nrirqs, domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: unable to add irq domain\n", np);
 		ret = -ENOMEM;
@@ -146,7 +146,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
 	}
 
-	irq_set_chained_handler_and_data(irq, dw_apb_ictl_handler, domain);
+	irq_set_chained_handler_and_data(parent_irq,
+				dw_apb_ictl_handle_irq_cascaded, domain);
 
 	return 0;
 
-- 
2.26.0.106.g9fadedd


