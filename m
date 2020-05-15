Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00132C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06D82076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589561888;
	bh=WyzQ92ApewIu4RHvp2WXU8VIKb29Z5HwrMixhKJyzeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KGnQJIPbP4grUMGUq4mTo/TamywhRsUXMqOlGI0KvbopFY6mrsg166GQSsMa9084T
	 k7FgwlhUIDvhbEwXa+QeHaGOzs9ZWgw5hKwo8lkiVwM1DkMLUkwerz3mKP0rKjptzQ
	 B98CzwVK1QoDQr+BwbI1z586Z12PeOFadu7m5ttg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgEOQ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOQ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:58:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272412073E;
        Fri, 15 May 2020 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589561884;
        bh=WyzQ92ApewIu4RHvp2WXU8VIKb29Z5HwrMixhKJyzeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLvAaYdIIa038jexo8NsziT2hNt4ezFnW1s7SbDhdgbkMIvqzR5+Bvp344d53SwIq
         NUJnawybcvFTmcRS95ffIr/UOR6Y8EMVipN3OfPFXFnt01Hk2JFDMiU6Wna69KmZyq
         nQU58ZQido6x5Ff3xfF0/uD2hXMVN/AnjEE61QvE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZdes-00Cdec-HO; Fri, 15 May 2020 17:58:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     John Garry <john.garry@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: [PATCH v4 2/2] irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
Date:   Fri, 15 May 2020 17:57:52 +0100
Message-Id: <20200515165752.121296-3-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515165752.121296-1-maz@kernel.org>
References: <20200515165752.121296-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, john.garry@huawei.com, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de, kernel-team@android.com
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
 drivers/irqchip/irq-gic-v3-its.c | 127 ++++++++++++++++++++++++-------
 1 file changed, 100 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4eb8441d0c2b..2aaf1e6bdc89 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1541,15 +1541,104 @@ static void its_dec_lpi_count(struct irq_data *d, int cpu)
 		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
 }
 
+static unsigned int cpumask_pick_least_loaded(struct irq_data *d,
+					      const struct cpumask *cpu_mask)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX;
+
+	for_each_cpu(tmp, cpu_mask) {
+		int this_count = its_read_lpi_count(d, tmp);
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
+			/*
+			 * Ideally, we would check if the mask is empty, and
+			 * try again on the full node here.
+			 *
+			 * But it turns out that the way API describes the
+			 * affinity for ITSs only deals about memory, and
+			 * not target CPUs, so it cannot describe a single
+			 * ITS placed next to two NUMA nodes.
+			 *
+			 * Instead, just fallback on the online mask. This
+			 * diverges from Thomas' suggestion above.
+			 */
+			cpu = cpumask_pick_least_loaded(d, tmpmask);
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
+		cpu = cpumask_pick_least_loaded(d, tmpmask);
+	} else {
+		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+
+		/* If we cannot cross sockets, limit the search to that node */
+		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
+		    node != NUMA_NO_NODE)
+			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
+
+		cpu = cpumask_pick_least_loaded(d, tmpmask);
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
-	int prev_cpu;
+	int cpu, prev_cpu;
 
 	/* A forwarded interrupt should use irq_set_vcpu_affinity */
 	if (irqd_is_forwarded_to_vcpu(d))
@@ -1558,18 +1647,12 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	prev_cpu = its_dev->event_map.col_map[id];
 	its_dec_lpi_count(d, prev_cpu);
 
-       /* lpi cannot be routed to a redistributor that is on a foreign node */
-	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-		if (its_dev->its->numa_node >= 0) {
-			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
-			if (!cpumask_intersects(mask_val, cpu_mask))
-				goto err;
-		}
-	}
-
-	cpu = cpumask_any_and(mask_val, cpu_mask);
+	if (!force)
+		cpu = its_select_cpu(d, mask_val);
+	else
+		cpu = cpumask_pick_least_loaded(d, mask_val);
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu < 0 || cpu >= nr_cpu_ids)
 		goto err;
 
 	/* don't set the affinity when the target cpu is same as current one */
@@ -3473,21 +3556,11 @@ static int its_irq_domain_activate(struct irq_domain *domain,
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
 
 	its_inc_lpi_count(d, cpu);
 	its_dev->event_map.col_map[event] = cpu;
-- 
2.26.2

