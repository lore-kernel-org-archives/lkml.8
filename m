Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21102C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50E3206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579460784;
	bh=Hsw7OlTEFGY3cuz403iXg0BPHXmGRLB1De7JAJ5DkeA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZdG5SWzmmLV7JE0XOXo/0nxjeam6uWZPEIi5J1jr1JkIS3aZ41b4hOF7bspZrnO+W
	 50+WnA29/JjKUsBUWXqH9jPDc/WzEnLXKpbWf4aS/+MjX4EsWRivhYl0csv73Iml6k
	 V9gZELWDWtQz4IeVPUiAkp/Z28rSn5mEPVAzEkmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgASTGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 14:06:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgASTGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:06:23 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C1420679;
        Sun, 19 Jan 2020 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579460782;
        bh=Hsw7OlTEFGY3cuz403iXg0BPHXmGRLB1De7JAJ5DkeA=;
        h=From:To:Cc:Subject:Date:From;
        b=eB/fBSqVQZ3WdK4SdaS5lgU0j+U+fUUCP03Lcz2/h+zRKyiqgX4WNrVf9XACLlzsn
         fY8W+LTv1YiALvHBqAxW/zxajPemo61e9eocXdKNEcK5H9Div1M83JPWmJ12raRLwx
         5ro4DMwGO5h8jQsYUyZkuaCJP1xRRf0DRmiiynpI=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itFts-0004bV-Js; Sun, 19 Jan 2020 19:06:20 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
Date:   Sun, 19 Jan 2020 19:05:54 +0000
Message-Id: <20200119190554.1002-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, john.garry@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mapping a LPI, the ITS driver picks the first possible
affinity, which is in most cases CPU0, assuming that if
that's not suitable, someone will come and set the affinity
to something more interesting.

It apparently isn't the case, and people complain of poor
performance when many interrupts are glued to the same CPU.
So let's place the interrupts by finding the "least loaded"
CPU (that is, the one that has the fewer LPIs mapped to it).
So called 'managed' interrupts are an interesting case where
the affinity is actually dictated by the kernel itself, and
we should honor this.

Reported-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/1575642904-58295-1-git-send-email-john.garry@huawei.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 120 +++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e05673bcd52b..ec50cc1b11a3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -177,6 +177,8 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
+static DEFINE_PER_CPU(atomic_t, cpu_lpi_count);
+
 static u16 get_its_list(struct its_vm *vm)
 {
 	struct its_node *its;
@@ -1287,42 +1289,96 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
 
+static int its_pick_target_cpu(const struct cpumask *cpu_mask)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX;
+
+	/*
+	 * If we're only picking one of the online CPUs, just pick the
+	 * first one (there are drivers that depend on this behaviour).
+	 * At some point, we'll have to weed them out.
+	 */
+	if (cpu_mask == cpu_online_mask)
+		return cpumask_first(cpu_mask);
+
+	for_each_cpu(tmp, cpu_mask) {
+		int this_count = per_cpu(cpu_lpi_count, tmp).counter;
+		if (this_count < count) {
+			cpu = tmp;
+		        count = this_count;
+		}
+	}
+
+	return cpu;
+}
+
+static void its_compute_affinity(struct irq_data *d,
+				 const struct cpumask *requested,
+				 struct cpumask *computed)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+
+	cpumask_and(computed, requested, cpu_online_mask);
+
+	/* LPI cannot be routed to a redistributor that is on a foreign node */
+	if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
+	    its_dev->its->numa_node >= 0)
+		cpumask_and(computed, computed,
+			    cpumask_of_node(its_dev->its->numa_node));
+}
+
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	unsigned int cpu;
-	const struct cpumask *cpu_mask = cpu_online_mask;
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	struct its_collection *target_col;
+	int ret = IRQ_SET_MASK_OK_DONE;
 	u32 id = its_get_event_id(d);
+	cpumask_var_t tmpmask;
+	struct cpumask *mask;
 
 	/* A forwarded interrupt should use irq_set_vcpu_affinity */
 	if (irqd_is_forwarded_to_vcpu(d))
 		return -EINVAL;
 
-       /* lpi cannot be routed to a redistributor that is on a foreign node */
-	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-		if (its_dev->its->numa_node >= 0) {
-			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
-			if (!cpumask_intersects(mask_val, cpu_mask))
-				return -EINVAL;
-		}
+	if (!force) {
+		if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+			return -ENOMEM;
+
+		mask = tmpmask;
+		its_compute_affinity(d, mask_val, mask);
+	} else	{
+		mask = (struct cpumask *)mask_val;
 	}
 
-	cpu = cpumask_any_and(mask_val, cpu_mask);
+	if (cpumask_empty(mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	if (!cpumask_test_cpu(its_dev->event_map.col_map[id], mask)) {
+		struct its_collection *target_col;
+		int cpu;
+
+		cpu = its_pick_target_cpu(mask);
+		if (cpu >= nr_cpu_ids) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-	/* don't set the affinity when the target cpu is same as current one */
-	if (cpu != its_dev->event_map.col_map[id]) {
+		atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
+		atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+				       its_dev->event_map.col_map[id]));
 		target_col = &its_dev->its->collections[cpu];
 		its_send_movi(its_dev, target_col, id);
 		its_dev->event_map.col_map[id] = cpu;
 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	}
 
-	return IRQ_SET_MASK_OK_DONE;
+out:
+	if (!force)
+		free_cpumask_var(tmpmask);
+	return ret;
 }
 
 static u64 its_irq_get_msi_base(struct its_device *its_dev)
@@ -2773,28 +2829,34 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	const struct cpumask *cpu_mask = cpu_online_mask;
-	int cpu;
+	int ret = 0, cpu = nr_cpu_ids;
+	const struct cpumask *reqmask;
+	cpumask_var_t mask;
 
-	/* get the cpu_mask of local node */
-	if (its_dev->its->numa_node >= 0)
-		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
+	if (irqd_affinity_is_managed(d))
+		reqmask = irq_data_get_affinity_mask(d);
+	else
+		reqmask = cpu_online_mask;
 
-	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids) {
-		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
-			return -EINVAL;
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
 
-		cpu = cpumask_first(cpu_online_mask);
+	its_compute_affinity(d, reqmask, mask);
+	cpu = its_pick_target_cpu(mask);
+	if (cpu >= nr_cpu_ids) {
+		ret = -EINVAL;
+		goto out;
 	}
 
+	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	/* Map the GIC IRQ and event to the device */
 	its_send_mapti(its_dev, d->hwirq, event);
-	return 0;
+out:
+	free_cpumask_var(mask);
+	return ret;
 }
 
 static void its_irq_domain_deactivate(struct irq_domain *domain,
@@ -2803,6 +2865,8 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+			       its_dev->event_map.col_map[event]));
 	/* Stop the delivery of interrupts */
 	its_send_discard(its_dev, event);
 }
-- 
2.20.1

