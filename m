Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114CDC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B8421924
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgC2U0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgC2U0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVf-0001Qi-Ds; Sun, 29 Mar 2020 22:26:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 90A251C0334;
        Sun, 29 Mar 2020 22:26:16 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Ensure mutual exclusion between vPE
 affinity change and RD access
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-4-maz@kernel.org>
References: <20200304203330.4967-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551357620.28353.9832405249088533311.tip-bot2@tip-bot2>
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

Commit-ID:     f3a059219bc718ccc3bf3ff894f089b7e9a93139
Gitweb:        https://git.kernel.org/tip/f3a059219bc718ccc3bf3ff894f089b7e9a93139
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:10 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 19 Mar 2020 11:21:58 

irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access

Before GICv4.1, all operations would be serialized with the affinity
changes by virtue of using the same ITS command queue. With v4.1, things
change, as invalidations (and a number of other operations) are issued
using the redistributor MMIO frame.

We must thus make sure that these redistributor accesses cannot race
against aginst the affinity change, or we may end-up talking to the
wrong redistributor.

To ensure this, we expand the irq_to_cpuid() helper to take a spinlock
when the LPI is mapped to a vLPI (a new per-VPE lock) on each operation
that requires mutual exclusion.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-4-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 56 ++++++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-v4.h |  5 +++-
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index da883a6..1af7139 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -239,15 +239,41 @@ static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
 	return NULL;
 }
 
-static int irq_to_cpuid(struct irq_data *d)
+static int vpe_to_cpuid_lock(struct its_vpe *vpe, unsigned long *flags)
+{
+	raw_spin_lock_irqsave(&vpe->vpe_lock, *flags);
+	return vpe->col_idx;
+}
+
+static void vpe_to_cpuid_unlock(struct its_vpe *vpe, unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
+}
+
+static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 {
-	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_vlpi_map *map = get_vlpi_map(d);
+	int cpu;
 
-	if (map)
-		return map->vpe->col_idx;
+	if (map) {
+		cpu = vpe_to_cpuid_lock(map->vpe, flags);
+	} else {
+		/* Physical LPIs are already locked via the irq_desc lock */
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+		cpu = its_dev->event_map.col_map[its_get_event_id(d)];
+		/* Keep GCC quiet... */
+		*flags = 0;
+	}
 
-	return its_dev->event_map.col_map[its_get_event_id(d)];
+	return cpu;
+}
+
+static void irq_to_cpuid_unlock(struct irq_data *d, unsigned long flags)
+{
+	struct its_vlpi_map *map = get_vlpi_map(d);
+
+	if (map)
+		vpe_to_cpuid_unlock(map->vpe, flags);
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -1329,7 +1355,9 @@ static void direct_lpi_inv(struct irq_data *d)
 {
 	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
+	unsigned long flags;
 	u64 val;
+	int cpu;
 
 	if (map) {
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -1344,10 +1372,12 @@ static void direct_lpi_inv(struct irq_data *d)
 	}
 
 	/* Target the redistributor this LPI is currently routed to */
-	rdbase = per_cpu_ptr(gic_rdists->rdist, irq_to_cpuid(d))->rd_base;
+	cpu = irq_to_cpuid_lock(d, &flags);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVLPIR);
 
 	wait_for_syncr(rdbase);
+	irq_to_cpuid_unlock(d, flags);
 }
 
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
@@ -3486,17 +3516,25 @@ static int its_vpe_set_affinity(struct irq_data *d,
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	int from, cpu = cpumask_first(mask_val);
+	unsigned long flags;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
 	 * we can and only do it if we really have to. Also, if mapped
 	 * into the proxy device, we need to move the doorbell
 	 * interrupt to its new location.
+	 *
+	 * Another thing is that changing the affinity of a vPE affects
+	 * *other interrupts* such as all the vLPIs that are routed to
+	 * this vPE. This means that the irq_desc lock is not enough to
+	 * protect us, and that we must ensure nobody samples vpe->col_idx
+	 * during the update, hence the lock below which must also be
+	 * taken on any vLPI handling path that evaluates vpe->col_idx.
 	 */
-	if (vpe->col_idx == cpu)
+	from = vpe_to_cpuid_lock(vpe, &flags);
+	if (from == cpu)
 		goto out;
 
-	from = vpe->col_idx;
 	vpe->col_idx = cpu;
 
 	/*
@@ -3512,6 +3550,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 
 out:
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+	vpe_to_cpuid_unlock(vpe, flags);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -3855,6 +3894,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return -ENOMEM;
 	}
 
+	raw_spin_lock_init(&vpe->vpe_lock);
 	vpe->vpe_id = vpe_id;
 	vpe->vpt_page = vpt_page;
 	if (gic_rdists->has_rvpeid)
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index d9c3496..439963f 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -54,6 +54,11 @@ struct its_vpe {
 	};
 
 	/*
+	 * Ensures mutual exclusion between affinity setting of the
+	 * vPE and vLPI operations using vpe->col_idx.
+	 */
+	raw_spinlock_t		vpe_lock;
+	/*
 	 * This collection ID is used to indirect the target
 	 * redistributor for this VPE. The ID itself isn't involved in
 	 * programming of the ITS.
