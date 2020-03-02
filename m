Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF6EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243424682
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aw2nU/wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCBXNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:13:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21112 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCBXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583190833; x=1614726833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mjs7be7Jt2PfOz6LF6Rk11t6ekJAzXeK7FYTH2QG7xw=;
  b=aw2nU/wxB2wYXuaqkuYBuPWtBNuY/F+vtEawCVvumYMNN8+2KcWIKF6m
   NE9BIPn/BJguXC38NrjZaqRk0/lpIKx9IDGRz3jFzB+2HLRU4Wkos+iO0
   FDl8PeH7B+MToMugxX4ffFdc+H3zlRt7Zedc08Fq4dgF3z/nezgmH4jI9
   4y5ZBHxkV6T7uotE7oucmj6IsVTQue6kN+Fdwi6W9VtE21OevPt/vmpI7
   5kSuLUlnANFRSqrTG9HexKmHK7+I4Nl+2XDuK1w2ilUh1wVZa/xQ7rMC1
   A8/I/drv+nMwJDRID2CWWUJv3WsfDiZ2mm4t58kfmfVaDsZIkFe2Qgy98
   A==;
IronPort-SDR: pAk9qwzMPRk19Gcaa2QQuHmccyCQvavKi/JEei3Xp5xpWbK6wmkliRcdbMKkKIC+3zZZqmNN/K
 hiNbAV37KtgQ0Xb6+oL1of8OV9l4G9u4rC2GFvSnb3n63IEsDkhaUE5zyZXhxzFx6UkUiBMy7W
 QKUSb47UK1txxoiu7AR4p8SdzOmaGnwFcELG3sv2N9KsQ+Lv9yDBRoNA6NIC5onUXzBB1lRnlq
 pAooEya9xUhXc8PvT+UekKR50wMEaNc/q5Qb+5q/1dQC9fQmRqsTxPIye2J3jbhfWvfi+UKjie
 IdM=
X-IronPort-AV: E=Sophos;i="5.70,508,1574092800"; 
   d="scan'208";a="131708415"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 07:13:52 +0800
IronPort-SDR: yZpHmi2gSNoCe9DIUWTjY4dHGF2YkocuCi84qwj9bZN8tZa0cKq+G/BlX5OoiRG2D17HBjTh3g
 PZ12J78xsoHag6CRr3IFD2o6MBfS278+x9e47ajpG+i7nLeJ1ybqHrpuSE07W5GZFSSAsRECF0
 CeO5WN2vAh0QNoOPUFT2bmu6SRwoV9A+PWt7hR4KtfckdAGK8AXFadXnSomZgQaa4IFwzTo5Mn
 g0cLyJleoecCZ01WmRp+WCb6V0u0MKgUaPDwOxA8FQ68VSRum7xu3zqd6BLyvuIhqy/RWSVAyb
 RF4YMJOchCGkX1jjPsvysali
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 15:06:08 -0800
IronPort-SDR: UvUo/F33SJdtlcBWIL2Kco3te34Zifbebw4+5JxuHLG+p0jo1p4F+q5MVTtgASDhqRG3HrOMI9
 Hc0BmZnLxBrNj8W/gM4O4u4+eYI45N0KHfw7lD/eDhrygj0u0+ATRSRTU8G3a4sejTwhsW2srP
 ksv7Ek8oHmmYGtzzuX1rSRfeWCdkk1Lw/bXNC6FgcwP1AGVYR50q1YWSemF7GRwdwy41mB2Kme
 9u+yxtwY1Bwe7F7GAtr1FvsG7uflcop4a5JmStae2UCxUIFMgOzRtIA2fm5mJ5zApRKQpv6Cqa
 y2s=
WDCIronportException: Internal
Received: from usa002267.ad.shared (HELO yoda.hgst.com) ([10.86.54.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2020 15:13:52 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Anup Patel <anup.patel@wdc.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v3 2/2] irqchip/sifive-plic: Add support for multiple PLICs
Date:   Mon,  2 Mar 2020 15:11:46 -0800
Message-Id: <20200302231146.15530-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302231146.15530-1-atish.patra@wdc.com>
References: <20200302231146.15530-1-atish.patra@wdc.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 81 +++++++++++++++++++------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7c7f37393f99..c34fb3ae0ff8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -59,7 +59,11 @@
 #define	PLIC_DISABLE_THRESHOLD		0xf
 #define	PLIC_ENABLE_THRESHOLD		0
 
-static void __iomem *plic_regs;
+struct plic_priv {
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
+	struct plic_priv	*priv;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
@@ -88,31 +93,40 @@ static inline void plic_toggle(struct plic_handler *handler,
 }
 
 static inline void plic_irq_toggle(const struct cpumask *mask,
-				   int hwirq, int enable)
+				   struct irq_data *d, int enable)
 {
 	int cpu;
+	struct plic_priv *priv = irq_get_chip_data(d->irq);
 
-	writel(enable, plic_regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
-		if (handler->present)
-			plic_toggle(handler, hwirq, enable);
+		if (handler->present &&
+		    cpumask_test_cpu(cpu, &handler->priv->lmask))
+			plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
 static void plic_irq_unmask(struct irq_data *d)
 {
-	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   cpu_online_mask);
+	struct cpumask amask;
+	unsigned int cpu;
+	struct plic_priv *priv = irq_get_chip_data(d->irq);
+
+	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
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
+	struct plic_priv *priv = irq_get_chip_data(d->irq);
+
+	plic_irq_toggle(&priv->lmask, d, 0);
 }
 
 #ifdef CONFIG_SMP
@@ -120,17 +134,21 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
+	struct cpumask amask;
+	struct plic_priv *priv = irq_get_chip_data(d->irq);
+
+	cpumask_and(&amask, &priv->lmask, mask_val);
 
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
+	plic_irq_toggle(&priv->lmask, d, 0);
+	plic_irq_toggle(cpumask_of(cpu), d, 1);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -191,8 +209,6 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.free		= irq_domain_free_irqs_top,
 };
 
-static struct irq_domain *plic_irqdomain;
-
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -209,7 +225,7 @@ static void plic_handle_irq(struct pt_regs *regs)
 
 	csr_clear(CSR_IE, IE_EIE);
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(plic_irqdomain, hwirq);
+		int irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
 
 		if (unlikely(irq <= 0))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
@@ -265,15 +281,17 @@ static int __init plic_init(struct device_node *node,
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
+	struct plic_priv *priv;
 
-	if (plic_regs) {
-		pr_warn("PLIC already present.\n");
-		return -ENXIO;
-	}
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
-	plic_regs = of_iomap(node, 0);
-	if (WARN_ON(!plic_regs))
-		return -EIO;
+	priv->regs = of_iomap(node, 0);
+	if (WARN_ON(!priv->regs)) {
+		error = -EIO;
+		goto out_free_priv;
+	}
 
 	error = -EINVAL;
 	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
@@ -287,9 +305,9 @@ static int __init plic_init(struct device_node *node,
 		goto out_iounmap;
 
 	error = -ENOMEM;
-	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, NULL);
-	if (WARN_ON(!plic_irqdomain))
+	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
+			&plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
 		goto out_iounmap;
 
 	for (i = 0; i < nr_contexts; i++) {
@@ -334,13 +352,14 @@ static int __init plic_init(struct device_node *node,
 			goto done;
 		}
 
+		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base =
-			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+			priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base =
-			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
-
+			priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+		handler->priv = priv;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
@@ -356,7 +375,9 @@ static int __init plic_init(struct device_node *node,
 	return 0;
 
 out_iounmap:
-	iounmap(plic_regs);
+	iounmap(priv->regs);
+out_free_priv:
+	kfree(priv);
 	return error;
 }
 
-- 
2.25.0

