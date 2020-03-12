Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E49C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3622206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584014163;
	bh=+GnKn6514vAqg8WcvSlSps8JLOTqenGr5L6t9cZHkRQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZKZICf4JW4KjV3GxD7eFKbwcnu8LXSWZgDEZmsY44iTtJtGCKjqJqO7BI5X+oyHwv
	 XS6r2vadzi2i2TV55OYfQU7qCM8xhlUU2Q34kIAFaNl6sbEo/Qqwr+jKvqttjWxTdE
	 TP6gy0M4gPuml949I2WtoCPPDzzb5rsvkU36/6r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgCLL4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgCLL4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:56:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FF620674;
        Thu, 12 Mar 2020 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584014161;
        bh=+GnKn6514vAqg8WcvSlSps8JLOTqenGr5L6t9cZHkRQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PG8W84ylP8DzW06aGyJpMV/AA7zsfRaPoa2TW46fJ3Bcm+p57DvEIsMmRC/k9qrlF
         pwiD5yXZ52tnmhDk/Dfl5/K4reFhC2x8o0uf94qkewbOAgZ4wiT/TshMDLcIOfqukQ
         uXfMi2cX1NRn84iAfa6RafyRAnbQe34QmN9TuvDY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jCMRT-00CCir-3r; Thu, 12 Mar 2020 11:55:59 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2] irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
Date:   Thu, 12 Mar 2020 11:55:52 +0000
Message-Id: <20200312115552.29185-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, john.garry@huawei.com, ming.lei@redhat.com
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
Cc: John Garry <john.garry@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
Reviving this at John's request. The major change is that the
affinity follows the x86 model, as described by Thomas.
I expect this to have an impact on platforms like D05, where
the SAS driver cannot use managed affinity just yet.

 drivers/irqchip/irq-gic-v3-its.c | 125 ++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 70d612adf15f..ee5568c20212 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -189,6 +189,8 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
+static DEFINE_PER_CPU(atomic_t, cpu_lpi_count);
+
 static u16 get_its_list(struct its_vm *vm)
 {
 	struct its_node *its;
@@ -1500,35 +1502,113 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
 
+static unsigned int cpumask_pick_least_loaded(const struct cpumask *cpu_mask)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX;
+
+	for_each_cpu(tmp, cpu_mask) {
+		int this_count = atomic_read(per_cpu_ptr(&cpu_lpi_count, tmp));
+		if (this_count < count) {
+			cpu = tmp;
+		        count = this_count;
+		}
+	}
+
+	return cpu;
+}
+
+/*
+ * As suggested by Thomas Gleixner in:
+ * https://lore.kernel.org/r/87h80q2aoc.fsf@nanos.tec.linutronix.de
+ */
+static int its_select_cpu(struct irq_data *d,
+			  const struct cpumask *aff_mask)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	cpumask_var_t tmpmask;
+	int cpu, node;
+
+	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	node = its_dev->its->numa_node;
+
+	if (!irqd_affinity_is_managed(d)) {
+		/* First try the NUMA node */
+		if (node != NUMA_NO_NODE) {
+			/*
+			 * Try the intersection of the affinity mask and the
+			 * node mask (and the online mask, just to be safe).
+			 */
+			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
+			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
+
+			/* If that doesn't work, try the nodemask itself */
+			if (cpumask_empty(tmpmask))
+				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);
+
+			cpu = cpumask_pick_least_loaded(tmpmask);
+			if (cpu < nr_cpu_ids)
+				goto out;
+
+			/* If we can't cross sockets, give up */
+			if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144))
+				goto out;
+
+			/* If the above failed, expand the search */
+		}
+
+		/* Try the intersection of the affinity and online masks */
+		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
+
+		/* If that doesn't fly, the online mask is the last resort */
+		if (cpumask_empty(tmpmask))
+			cpumask_copy(tmpmask, cpu_online_mask);
+
+		cpu = cpumask_pick_least_loaded(tmpmask);
+	} else {
+		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+
+		/* If we cannot cross sockets, limit the search to that node */
+		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
+		    node != NUMA_NO_NODE)
+			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
+
+		cpu = cpumask_pick_least_loaded(tmpmask);
+	}
+out:
+	free_cpumask_var(tmpmask);
+
+	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
+	return cpu;
+}
+
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	unsigned int cpu;
-	const struct cpumask *cpu_mask = cpu_online_mask;
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_collection *target_col;
 	u32 id = its_get_event_id(d);
+	int cpu;
 
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
-	}
-
-	cpu = cpumask_any_and(mask_val, cpu_mask);
+	if (!force)
+		cpu = its_select_cpu(d, mask_val);
+	else
+		cpu = cpumask_pick_least_loaded(mask_val);
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu < 0 || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
 	/* don't set the affinity when the target cpu is same as current one */
 	if (cpu != its_dev->event_map.col_map[id]) {
+		atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
+		atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+				       its_dev->event_map.col_map[id]));
 		target_col = &its_dev->its->collections[cpu];
 		its_send_movi(its_dev, target_col, id);
 		its_dev->event_map.col_map[id] = cpu;
@@ -3390,22 +3470,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	const struct cpumask *cpu_mask = cpu_online_mask;
 	int cpu;
 
-	/* get the cpu_mask of local node */
-	if (its_dev->its->numa_node >= 0)
-		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
-
-	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids) {
-		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
-			return -EINVAL;
-
-		cpu = cpumask_first(cpu_online_mask);
-	}
+	cpu = its_select_cpu(d, cpu_online_mask);
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
 
+	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -3420,6 +3491,8 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+			       its_dev->event_map.col_map[event]));
 	/* Stop the delivery of interrupts */
 	its_send_discard(its_dev, event);
 }
-- 
2.20.1

