Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8385020776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgE3HrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgE3Hqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA1AC08C5D1;
        Sat, 30 May 2020 00:46:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCU-0001sc-FD; Sat, 30 May 2020 09:46:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E7D761C04D6;
        Sat, 30 May 2020 09:46:37 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:37 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
Cc:     Marc Zyngier <maz@kernel.org>, John Garry <john.garry@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200515165752.121296-2-maz@kernel.org>
References: <20200515165752.121296-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <159082479780.17951.14474657424111397931.tip-bot2@tip-bot2>
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

Commit-ID:     2f13ff1d1d5c0257c97ea76b86a2d9c99c44a4b9
Gitweb:        https://git.kernel.org/tip/2f13ff1d1d5c0257c97ea76b86a2d9c99c44a4b9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 15 May 2020 17:57:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 18 May 2020 10:30:42 +01:00

irqchip/gic-v3-its: Track LPI distribution on a per CPU basis

In order to improve the distribution of LPIs among CPUs, let start by
tracking the number of LPIs assigned to CPUs, both for managed and
non-managed interrupts (as separate counters).

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/20200515165752.121296-2-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 49 +++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 124251b..4eb8441 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -174,6 +174,13 @@ static struct {
 	int			next_victim;
 } vpe_proxy;
 
+struct cpu_lpi_count {
+	atomic_t	managed;
+	atomic_t	unmanaged;
+};
+
+static DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
+
 static LIST_HEAD(its_nodes);
 static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
@@ -1510,6 +1517,30 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
 
+static __maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+
+	return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static void its_inc_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+	else
+		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static void its_dec_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+	else
+		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
@@ -1518,34 +1549,44 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_collection *target_col;
 	u32 id = its_get_event_id(d);
+	int prev_cpu;
 
 	/* A forwarded interrupt should use irq_set_vcpu_affinity */
 	if (irqd_is_forwarded_to_vcpu(d))
 		return -EINVAL;
 
+	prev_cpu = its_dev->event_map.col_map[id];
+	its_dec_lpi_count(d, prev_cpu);
+
        /* lpi cannot be routed to a redistributor that is on a foreign node */
 	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
 		if (its_dev->its->numa_node >= 0) {
 			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 			if (!cpumask_intersects(mask_val, cpu_mask))
-				return -EINVAL;
+				goto err;
 		}
 	}
 
 	cpu = cpumask_any_and(mask_val, cpu_mask);
 
 	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+		goto err;
 
 	/* don't set the affinity when the target cpu is same as current one */
-	if (cpu != its_dev->event_map.col_map[id]) {
+	if (cpu != prev_cpu) {
 		target_col = &its_dev->its->collections[cpu];
 		its_send_movi(its_dev, target_col, id);
 		its_dev->event_map.col_map[id] = cpu;
 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	}
 
+	its_inc_lpi_count(d, cpu);
+
 	return IRQ_SET_MASK_OK_DONE;
+
+err:
+	its_inc_lpi_count(d, prev_cpu);
+	return -EINVAL;
 }
 
 static u64 its_irq_get_msi_base(struct its_device *its_dev)
@@ -3448,6 +3489,7 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu = cpumask_first(cpu_online_mask);
 	}
 
+	its_inc_lpi_count(d, cpu);
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -3462,6 +3504,7 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	its_dec_lpi_count(d, its_dev->event_map.col_map[event]);
 	/* Stop the delivery of interrupts */
 	its_send_discard(its_dev, event);
 }
