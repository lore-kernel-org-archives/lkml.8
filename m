Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E4C2D0E1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D8121741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgIIG7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:59:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgIIG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:59:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56372782562A495340CB;
        Wed,  9 Sep 2020 14:59:17 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 14:59:08 +0800
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
Subject: [PATCH v3 2/3] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Wed, 9 Sep 2020 14:58:35 +0800
Message-ID: <20200909065836.2631-3-thunder.leizhen@huawei.com>
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

Add support to use dw-apb-ictl as primary interrupt controller.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Haoyu Lv <lvhaoyu@huawei.com>
---
 drivers/irqchip/Kconfig           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c | 76 +++++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719dbcdc..7c2d1c8fa551 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -148,7 +148,7 @@ config DAVINCI_CP_INTC
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 
 config FARADAY_FTINTC010
 	bool
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 5458004242e9..3c7bebe1b947 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/interrupt.h>
 
 #define APB_INT_ENABLE_L	0x00
 #define APB_INT_ENABLE_H	0x04
@@ -26,6 +27,27 @@
 #define APB_INT_FINALSTATUS_H	0x34
 #define APB_INT_BASE_OFFSET	0x04
 
+/* irq domain of the primary interrupt controller. */
+static struct irq_domain *dw_apb_ictl_irq_domain;
+
+static void __irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
+{
+	struct irq_domain *d = dw_apb_ictl_irq_domain;
+	int n;
+
+	for (n = 0; n < d->revmap_size; n += 32) {
+		struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, n);
+		u32 stat = readl_relaxed(gc->reg_base + APB_INT_FINALSTATUS_L);
+
+		while (stat) {
+			u32 hwirq = ffs(stat) - 1;
+
+			handle_domain_irq(d, hwirq, regs);
+			stat &= ~BIT(hwirq);
+		}
+	}
+}
+
 static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
@@ -50,6 +72,30 @@ static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int dw_apb_ictl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_map_generic_chip(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops dw_apb_ictl_irq_domain_ops = {
+	.translate = irq_domain_translate_onecell,
+	.alloc = dw_apb_ictl_irq_domain_alloc,
+	.free = irq_domain_free_irqs_top,
+};
+
 #ifdef CONFIG_PM
 static void dw_apb_ictl_resume(struct irq_data *d)
 {
@@ -75,13 +121,20 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	void __iomem *iobase;
 	int ret, nrirqs, parent_irq, i;
 	u32 reg;
-	const struct irq_domain_ops *domain_ops = &irq_generic_chip_ops;
-
-	/* Map the parent interrupt for the chained handler */
-	parent_irq = irq_of_parse_and_map(np, 0);
-	if (parent_irq <= 0) {
-		pr_err("%pOF: unable to parse irq\n", np);
-		return -EINVAL;
+	const struct irq_domain_ops *domain_ops;
+
+	if (!parent || (np == parent)) {
+		/* It's used as the primary interrupt controller */
+		parent_irq = 0;
+		domain_ops = &dw_apb_ictl_irq_domain_ops;
+	} else {
+		/* Map the parent interrupt for the chained handler */
+		parent_irq = irq_of_parse_and_map(np, 0);
+		if (parent_irq <= 0) {
+			pr_err("%pOF: unable to parse irq\n", np);
+			return -EINVAL;
+		}
+		domain_ops = &irq_generic_chip_ops;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
@@ -144,10 +197,17 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
 		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
 		gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
+		if (!parent_irq)
+			gc->chip_types[0].chip.irq_eoi = irq_gc_noop;
 	}
 
-	irq_set_chained_handler_and_data(parent_irq,
+	if (parent_irq) {
+		irq_set_chained_handler_and_data(parent_irq,
 				dw_apb_ictl_handle_irq_cascaded, domain);
+	} else {
+		dw_apb_ictl_irq_domain = domain;
+		set_handle_irq(dw_apb_ictl_handle_irq);
+	}
 
 	return 0;
 
-- 
2.26.0.106.g9fadedd


