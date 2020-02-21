Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D89C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AA62072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SIgDkMi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgBUXX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:23:27 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60282 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBUXX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582327412; x=1613863412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oT2R0meeLStyZStuUidGKZsmZN+Qxv/GRFYMm+I3XE4=;
  b=SIgDkMi1ICbsBFCvoulV+hUH6pUQ187Iu2IhNeZZenISNPcRAXzHKMBQ
   JhTDAIm3+//2KOymKqRACJMS7GqhgEQ3QddGMgzApeLLH9q9/MsqyT8JQ
   s5u6qcy4IO2ZKNzU2G21nFOuoOoIRKl+Vm5QE7hRiZD0B564lUYof65aZ
   d66fBzi/WXukd//ESGLleCA1AFjIvzFw1XWYw7LQv2GNH8VFBaL6Ii+LQ
   9XLWrPGlsXUe9v5evJl4pBjgUvqV0S2e4YNy6H53gnsSxLv07WYyZQJyd
   mscOJCKaTZs7cOwm2E/VtF52Fy2/sUStGBiiTChiupacO23s7YzQwcFuP
   w==;
IronPort-SDR: U1gYKVHWmd6AVqDy0sV5jPKrcm4XkYkKqj2xlLEA1VoJjkWcL5+QbVNh2+st1dpI6+YlWto2jT
 0FMT3F296i8xnJlfimvq5OWtCW3EKqIAbIlIoyA7BwdqwxBEF01xyeApnxATikzYVw4Hl/eEIx
 uaNuo166nZXLZS/KIgG+TZb8hXe8qFe7/OglKxsK+Jtf4S1YXLDXP7bfWRrmWGl9cGxNOHCjJK
 Y+E4nwOQeA5+24yZOzmgpXrv/mkJ8jitSAnDbIsav88IXB0w7s8TTpdKphcgkxGDnjztioMQzH
 OfI=
X-IronPort-AV: E=Sophos;i="5.70,470,1574092800"; 
   d="scan'208";a="232307705"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 07:23:31 +0800
IronPort-SDR: 5SLCQd0DjZQFMuo/holc96R45MuBCD8KRvIw04e3v9R8vi6o6V4broNcM4QyyEy4cxzJOml52z
 oQy9AjZfaaxZiiYKxeKntRCjl+sA0KD4D/REL3xK+rr6dx6YDTt+IJkkcCMhlxbCvwyxFB5Uug
 fdiO6Q475+b3MR2rNIoeolCL2GETPGid+7nBL+eib19rkWnYXAaeO0Wspy9ZDbCoD0T3UHyBBu
 uXD8+7FQauiW0p7x65w64/fK/M/YnWsibf0/U1D+m2oFpuqRx9PYZzsG5hE1d7hJurVyyN/FBC
 A2WPO7mfYpstBGHe4V8WCL3K
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 15:15:58 -0800
IronPort-SDR: Mo93vb7y5Qr8CAlYW3THBEi4nwttZ3hDIkckXZ3un3d4jSpOVUUpNPbT4+UqeIpABwJ/9V/Im+
 hjBIwtqmFoaZmW5eU4wUi9HE2T86d9kY4YvLUcuW5kcZPndihml/KUjmkLtJhUraO1fkILBN1c
 AP2rHzQQlWPQW3DK2zdBbYQnVaCNisYiFOuxddx45mXdKFGMyGhDCwyL7Tb62fwyan3RTlAhlj
 1TlnsWdLwT84ianehFaMI0QfpJFPyFbg3yXgDhtq4U+gSB+zlw3a6KZ5evzdMTvJlRuCTmIyGJ
 V14=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2020 15:23:26 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v2 PATCH] irqchip/sifive-plic: Add support for multiple PLICs
Date:   Fri, 21 Feb 2020 15:22:46 -0800
Message-Id: <20200221232246.9176-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current, PLIC driver can support only 1 PLIC on the board. However,
there can be multiple PLICs present on a two socket systems in RISC-V.

Modify the driver so that each PLIC handler can have a information
about individual PLIC registers and an irqdomain associated with it.

Tested on two socket RISC-V system based on VCU118 FPGA connected via
OmniXtend protocol.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
This patch is rebased on top of 5.6-rc2 and following plic fix from
hotplug series.

https://lkml.org/lkml/2020/2/20/1220

Changes from v1->v2:
1. Use irq_chip_get_data to retrieve host_data
2. Renamed plic_hw to plic_node_ctx
---
 drivers/irqchip/irq-sifive-plic.c | 82 ++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7c7f37393f99..9b9b6f4def4f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -59,7 +59,11 @@
 #define	PLIC_DISABLE_THRESHOLD		0xf
 #define	PLIC_ENABLE_THRESHOLD		0
 
-static void __iomem *plic_regs;
+struct plic_node_ctx {
+	struct cpumask lmask;
+	struct irq_domain *irqdomain;
+	void __iomem *regs;
+};
 
 struct plic_handler {
 	bool			present;
@@ -70,6 +74,7 @@ struct plic_handler {
 	 */
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
+	struct plic_node_ctx		*node_ctx;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
@@ -88,31 +93,41 @@ static inline void plic_toggle(struct plic_handler *handler,
 }
 
 static inline void plic_irq_toggle(const struct cpumask *mask,
-				   int hwirq, int enable)
+				   struct irq_data *d, int enable)
 {
 	int cpu;
+	struct plic_node_ctx *node_ctx = irq_get_chip_data(d->irq);
 
-	writel(enable, plic_regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	writel(enable,
+	       node_ctx->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
-		if (handler->present)
-			plic_toggle(handler, hwirq, enable);
+		if (handler->present &&
+		    cpumask_test_cpu(cpu, &handler->node_ctx->lmask))
+			plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
 static void plic_irq_unmask(struct irq_data *d)
 {
-	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   cpu_online_mask);
+	struct cpumask amask;
+	unsigned int cpu;
+	struct plic_node_ctx *node_ctx = irq_get_chip_data(d->irq);
+
+	cpumask_and(&amask, &node_ctx->lmask, cpu_online_mask);
+	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
+					   &amask);
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
 		return;
-	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+	plic_irq_toggle(cpumask_of(cpu), d, 1);
 }
 
 static void plic_irq_mask(struct irq_data *d)
 {
-	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
+	struct plic_node_ctx *node_ctx = irq_get_chip_data(d->irq);
+
+	plic_irq_toggle(&node_ctx->lmask, d, 0);
 }
 
 #ifdef CONFIG_SMP
@@ -120,17 +135,21 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
+	struct cpumask amask;
+	struct plic_node_ctx *node_ctx = irq_get_chip_data(d->irq);
+
+	cpumask_and(&amask, &node_ctx->lmask, mask_val);
 
 	if (force)
-		cpu = cpumask_first(mask_val);
+		cpu = cpumask_first(&amask);
 	else
-		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+		cpu = cpumask_any_and(&amask, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
-	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+	plic_irq_toggle(&node_ctx->lmask, d, 0);
+	plic_irq_toggle(cpumask_of(cpu), d, 1);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -191,8 +210,6 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.free		= irq_domain_free_irqs_top,
 };
 
-static struct irq_domain *plic_irqdomain;
-
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -209,7 +226,7 @@ static void plic_handle_irq(struct pt_regs *regs)
 
 	csr_clear(CSR_IE, IE_EIE);
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(plic_irqdomain, hwirq);
+		int irq = irq_find_mapping(handler->node_ctx->irqdomain, hwirq);
 
 		if (unlikely(irq <= 0))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
@@ -265,15 +282,17 @@ static int __init plic_init(struct device_node *node,
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
+	struct plic_node_ctx *node_ctx;
 
-	if (plic_regs) {
-		pr_warn("PLIC already present.\n");
-		return -ENXIO;
-	}
+	node_ctx = kzalloc(sizeof(*node_ctx), GFP_KERNEL);
+	if (!node_ctx)
+		return -ENOMEM;
 
-	plic_regs = of_iomap(node, 0);
-	if (WARN_ON(!plic_regs))
-		return -EIO;
+	node_ctx->regs = of_iomap(node, 0);
+	if (WARN_ON(!node_ctx->regs)) {
+		error = -EIO;
+		goto out_free_nctx;
+	}
 
 	error = -EINVAL;
 	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
@@ -287,9 +306,9 @@ static int __init plic_init(struct device_node *node,
 		goto out_iounmap;
 
 	error = -ENOMEM;
-	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, NULL);
-	if (WARN_ON(!plic_irqdomain))
+	node_ctx->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
+			&plic_irqdomain_ops, node_ctx);
+	if (WARN_ON(!node_ctx->irqdomain))
 		goto out_iounmap;
 
 	for (i = 0; i < nr_contexts; i++) {
@@ -334,13 +353,14 @@ static int __init plic_init(struct device_node *node,
 			goto done;
 		}
 
+		cpumask_set_cpu(cpu, &node_ctx->lmask);
 		handler->present = true;
 		handler->hart_base =
-			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+			node_ctx->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base =
-			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
-
+			node_ctx->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+		handler->node_ctx = node_ctx;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
@@ -356,7 +376,9 @@ static int __init plic_init(struct device_node *node,
 	return 0;
 
 out_iounmap:
-	iounmap(plic_regs);
+	iounmap(node_ctx->regs);
+out_free_nctx:
+	kfree(node_ctx);
 	return error;
 }
 
-- 
2.25.0

