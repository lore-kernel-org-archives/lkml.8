Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525D320784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgC2U0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgC2U0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVq-0001Ug-W1; Sun, 29 Mar 2020 22:26:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9635A1C070D;
        Sun, 29 Mar 2020 22:26:21 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:21 -0000
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Add support for multiple PLICs
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302231146.15530-3-atish.patra@wdc.com>
References: <20200302231146.15530-3-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <158551358111.28353.4832719273444577850.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f1ad1133b18f2aed3f6923cdb62b63da230accfd
Gitweb:        https://git.kernel.org/tip/f1ad1133b18f2aed3f6923cdb62b63da230accfd
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Mon, 02 Mar 2020 15:11:46 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:54 

irqchip/sifive-plic: Add support for multiple PLICs

Current, PLIC driver can support only 1 PLIC on the board. However,
there can be multiple PLICs present on a two socket systems in RISC-V.

Modify the driver so that each PLIC handler can have a information
about individual PLIC registers and an irqdomain associated with it.

Tested on two socket RISC-V system based on VCU118 FPGA connected via
OmniXtend protocol.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20200302231146.15530-3-atish.patra@wdc.com
---
 drivers/irqchip/irq-sifive-plic.c | 81 ++++++++++++++++++------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7c7f373..c34fb3a 100644
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
@@ -356,7 +375,9 @@ done:
 	return 0;
 
 out_iounmap:
-	iounmap(plic_regs);
+	iounmap(priv->regs);
+out_free_priv:
+	kfree(priv);
 	return error;
 }
 
