Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76094C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509D921D1A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgIHHMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:12:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728562AbgIHHMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:12:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F34C10494B93BEF3F5A;
        Tue,  8 Sep 2020 15:12:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 15:12:28 +0800
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
Subject: [PATCH v2 2/3] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Tue, 8 Sep 2020 15:11:33 +0800
Message-ID: <20200908071134.2578-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200908071134.2578-1-thunder.leizhen@huawei.com>
References: <20200908071134.2578-1-thunder.leizhen@huawei.com>
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
 drivers/irqchip/irq-dw-apb-ictl.c | 75 +++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 4 deletions(-)

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
index aa6214da0b1f..405861322596 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <asm/exception.h>
 
 #define APB_INT_ENABLE_L	0x00
 #define APB_INT_ENABLE_H	0x04
@@ -26,6 +27,30 @@
 #define APB_INT_FINALSTATUS_H	0x34
 #define APB_INT_BASE_OFFSET	0x04
 
+/*
+ * irq domain of the primary interrupt controller. Currently, only one is
+ * supported.
+ */
+static struct irq_domain *dw_apb_ictl_irq_domain;
+
+static void __exception_irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
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
+			stat &= ~(1 << hwirq);
+		}
+	}
+}
+
 static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
@@ -50,6 +75,30 @@ static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
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
@@ -78,11 +127,24 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	const struct irq_domain_ops *domain_ops = &irq_generic_chip_ops;
 	irq_flow_handler_t flow_handler = handle_level_irq;
 
+	if (dw_apb_ictl_irq_domain) {
+		pr_err("%pOF: a hierarchy irq domain is already exist.\n", np);
+		return -EBUSY;
+	}
+
 	/* Map the parent interrupt for the chained handler */
 	parent_irq = irq_of_parse_and_map(np, 0);
 	if (parent_irq <= 0) {
-		pr_err("%pOF: unable to parse irq\n", np);
-		return -EINVAL;
+		/* It's used as secondary interrupt controller */
+		if (of_find_property(np, "interrupts", NULL)) {
+			pr_err("%pOF: unable to parse irq\n", np);
+			return -EINVAL;
+		}
+
+		/* It's used as the primary interrupt controller */
+		parent_irq = 0;
+		domain_ops = &dw_apb_ictl_irq_domain_ops;
+		flow_handler = handle_fasteoi_irq;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
@@ -145,10 +207,17 @@ static int __init dw_apb_ictl_init(struct device_node *np,
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


