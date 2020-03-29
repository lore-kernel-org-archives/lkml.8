Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B7FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64F92074A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgC2U0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2U0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVU-0001KF-DR; Sun, 29 Mar 2020 22:26:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE4CA1C0334;
        Sun, 29 Mar 2020 22:26:07 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:07 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Plumb get/set_irqchip_state SGI callbacks
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-12-maz@kernel.org>
References: <20200304203330.4967-12-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551356759.28353.1282710549164334441.tip-bot2@tip-bot2>
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

Commit-ID:     7017ff0ee1de9d45fafee88a4e7890cce92f482e
Gitweb:        https://git.kernel.org/tip/7017ff0ee1de9d45fafee88a4e7890cce92f482e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:18 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 24 Mar 2020 12:05:09 

irqchip/gic-v4.1: Plumb get/set_irqchip_state SGI callbacks

To implement the get/set_irqchip_state callbacks (limited to the
PENDING state), we have to use a particular set of hacks:

- Reading the pending state is done by using a pair of new redistributor
  registers (GICR_VSGIR, GICR_VSGIPENDR), which allow the 16 interrupts
  state to be retrieved.
- Setting the pending state is done by generating it as we'd otherwise do
  for a guest (writing to GITS_SGIR).
- Clearing the pending state is done by emitting a VSGI command with the
  "clear" bit set.

This requires some interesting locking though:
- When talking to the redistributor, we must make sure that the VPE
  affinity doesn't change, hence taking the VPE lock.
- At the same time, we must ensure that nobody accesses the same
  redistributor's GICR_VSGIR registers for a different VPE, which
  would corrupt the reading of the pending bits. We thus take the
  per-RD spinlock. Much fun.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-12-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 77 +++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h | 14 +++++-
 2 files changed, 91 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index bc6666a..c614f0c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3972,11 +3972,88 @@ static int its_sgi_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK;
 }
 
+static int its_sgi_set_irqchip_state(struct irq_data *d,
+				     enum irqchip_irq_state which,
+				     bool state)
+{
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	if (state) {
+		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+		struct its_node *its = find_4_1_its();
+		u64 val;
+
+		val  = FIELD_PREP(GITS_SGIR_VPEID, vpe->vpe_id);
+		val |= FIELD_PREP(GITS_SGIR_VINTID, d->hwirq);
+		writeq_relaxed(val, its->sgir_base + GITS_SGIR - SZ_128K);
+	} else {
+		its_configure_sgi(d, true);
+	}
+
+	return 0;
+}
+
+static int its_sgi_get_irqchip_state(struct irq_data *d,
+				     enum irqchip_irq_state which, bool *val)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	void __iomem *base;
+	unsigned long flags;
+	u32 count = 1000000;	/* 1s! */
+	u32 status;
+	int cpu;
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	/*
+	 * Locking galore! We can race against two different events:
+	 *
+	 * - Concurent vPE affinity change: we must make sure it cannot
+	 *   happen, or we'll talk to the wrong redistributor. This is
+	 *   identical to what happens with vLPIs.
+	 *
+	 * - Concurrent VSGIPENDR access: As it involves accessing two
+	 *   MMIO registers, this must be made atomic one way or another.
+	 */
+	cpu = vpe_to_cpuid_lock(vpe, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	base = gic_data_rdist_cpu(cpu)->rd_base + SZ_128K;
+	writel_relaxed(vpe->vpe_id, base + GICR_VSGIR);
+	do {
+		status = readl_relaxed(base + GICR_VSGIPENDR);
+		if (!(status & GICR_VSGIPENDR_BUSY))
+			goto out;
+
+		count--;
+		if (!count) {
+			pr_err_ratelimited("Unable to get SGI status\n");
+			goto out;
+		}
+		cpu_relax();
+		udelay(1);
+	} while (count);
+
+out:
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	vpe_to_cpuid_unlock(vpe, flags);
+
+	if (!count)
+		return -ENXIO;
+
+	*val = !!(status & (1 << d->hwirq));
+
+	return 0;
+}
+
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
 	.irq_mask		= its_sgi_mask_irq,
 	.irq_unmask		= its_sgi_unmask_irq,
 	.irq_set_affinity	= its_sgi_set_affinity,
+	.irq_set_irqchip_state	= its_sgi_set_irqchip_state,
+	.irq_get_irqchip_state	= its_sgi_get_irqchip_state,
 };
 
 static int its_sgi_irq_domain_alloc(struct irq_domain *domain,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index fd3be49..590cdbe 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -345,6 +345,15 @@
 #define GICR_VPENDBASER_4_1_VGRP1EN	(1ULL << 58)
 #define GICR_VPENDBASER_4_1_VPEID	GENMASK_ULL(15, 0)
 
+#define GICR_VSGIR			0x0080
+
+#define GICR_VSGIR_VPEID		GENMASK(15, 0)
+
+#define GICR_VSGIPENDR			0x0088
+
+#define GICR_VSGIPENDR_BUSY		(1U << 31)
+#define GICR_VSGIPENDR_PENDING		GENMASK(15, 0)
+
 /*
  * ITS registers, offsets from ITS_base
  */
@@ -368,6 +377,11 @@
 
 #define GITS_TRANSLATER			0x10040
 
+#define GITS_SGIR			0x20020
+
+#define GITS_SGIR_VPEID			GENMASK_ULL(47, 32)
+#define GITS_SGIR_VINTID		GENMASK_ULL(3, 0)
+
 #define GITS_CTLR_ENABLE		(1U << 0)
 #define GITS_CTLR_ImDe			(1U << 1)
 #define	GITS_CTLR_ITS_NUMBER_SHIFT	4
