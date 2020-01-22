Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D44C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF4E2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAVPeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:34:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:34:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuI1H-00088x-Rb; Wed, 22 Jan 2020 16:34:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 73ABB1C1A48;
        Wed, 22 Jan 2020 16:34:15 +0100 (CET)
Date:   Wed, 22 Jan 2020 15:34:15 -0000
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq, sched/isolation: Isolate from handling
 managed interrupts
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200120091625.17912-1-ming.lei@redhat.com>
References: <20200120091625.17912-1-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <157970725525.396.12620687191107603079.tip-bot2@tip-bot2>
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

Commit-ID:     11ea68f553e244851d15793a7fa33a97c46d8271
Gitweb:        https://git.kernel.org/tip/11ea68f553e244851d15793a7fa33a97c46d8271
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Mon, 20 Jan 2020 17:16:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jan 2020 16:29:49 +01:00

genirq, sched/isolation: Isolate from handling managed interrupts

The affinity of managed interrupts is completely handled in the kernel and
cannot be changed via the /proc/irq/* interfaces from user space. As the
kernel tries to spread out interrupts evenly accross CPUs on x86 to prevent
vector exhaustion, it can happen that a managed interrupt whose affinity
mask contains both isolated and housekeeping CPUs is routed to an isolated
CPU. As a consequence IO submitted on a housekeeping CPU causes interrupts
on the isolated CPU.

Add a new sub-parameter 'managed_irq' for 'isolcpus' and the corresponding
logic in the interrupt affinity selection code.

The subparameter indicates to the interrupt affinity selection logic that
it should try to avoid the above scenario.

This isolation is best effort and only effective if the automatically
assigned interrupt mask of a device queue contains isolated and
housekeeping CPUs. If housekeeping CPUs are online then such interrupts are
directed to the housekeeping CPU so that IO submitted on the housekeeping
CPU cannot disturb the isolated CPU.

If a queue's affinity mask contains only isolated CPUs then this parameter
has no effect on the interrupt routing decision, though interrupts are only
happening when tasks running on those isolated CPUs submit IO. IO submitted
on housekeeping CPUs has no influence on those queues.

If the affinity mask contains both housekeeping and isolated CPUs, but none
of the contained housekeeping CPUs is online, then the interrupt is also
routed to an isolated CPU. Interrupts are only delivered when one of the
isolated CPUs in the affinity mask submits IO. If one of the contained
housekeeping CPUs comes online, the CPU hotplug logic migrates the
interrupt automatically back to the upcoming housekeeping CPU. Depending on
the type of interrupt controller, this can require that at least one
interrupt is delivered to the isolated CPU in order to complete the
migration.

[ tglx: Removed unused parameter, added and edited comments/documentation
  	and rephrased the changelog so it contains more details. ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200120091625.17912-1-ming.lei@redhat.com

---
 Documentation/admin-guide/kernel-parameters.txt | 26 +++++++++-
 include/linux/sched/isolation.h                 |  1 +-
 kernel/irq/cpuhotplug.c                         | 21 +++++++-
 kernel/irq/manage.c                             | 41 +++++++++++++++-
 kernel/sched/isolation.c                        |  6 ++-
 5 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6e..765e427 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1933,9 +1933,31 @@
 			  <cpu number> begins at 0 and the maximum value is
 			  "number of CPUs in system - 1".
 
-			The format of <cpu-list> is described above.
-
+			managed_irq
+
+			  Isolate from being targeted by managed interrupts
+			  which have an interrupt mask containing isolated
+			  CPUs. The affinity of managed interrupts is
+			  handled by the kernel and cannot be changed via
+			  the /proc/irq/* interfaces.
+
+			  This isolation is best effort and only effective
+			  if the automatically assigned interrupt mask of a
+			  device queue contains isolated and housekeeping
+			  CPUs. If housekeeping CPUs are online then such
+			  interrupts are directed to the housekeeping CPU
+			  so that IO submitted on the housekeeping CPU
+			  cannot disturb the isolated CPU.
+
+			  If a queue's affinity mask contains only isolated
+			  CPUs then this parameter has no effect on the
+			  interrupt routing decision, though interrupts are
+			  only delivered when tasks running on those
+			  isolated CPUs submit IO. IO submitted on
+			  housekeeping CPUs has no influence on those
+			  queues.
 
+			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]
 
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 6c8512d..0fbcbac 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -13,6 +13,7 @@ enum hk_flags {
 	HK_FLAG_TICK		= (1 << 4),
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
+	HK_FLAG_MANAGED_IRQ	= (1 << 7),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 6c7ca2e..02236b1 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/ratelimit.h>
 #include <linux/irq.h>
+#include <linux/sched/isolation.h>
 
 #include "internals.h"
 
@@ -171,6 +172,20 @@ void irq_migrate_all_off_this_cpu(void)
 	}
 }
 
+static bool hk_should_isolate(struct irq_data *data, unsigned int cpu)
+{
+	const struct cpumask *hk_mask;
+
+	if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
+		return false;
+
+	hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+	if (cpumask_subset(irq_data_get_effective_affinity_mask(data), hk_mask))
+		return false;
+
+	return cpumask_test_cpu(cpu, hk_mask);
+}
+
 static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
@@ -188,9 +203,11 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	/*
 	 * If the interrupt can only be directed to a single target
 	 * CPU then it is already assigned to a CPU in the affinity
-	 * mask. No point in trying to move it around.
+	 * mask. No point in trying to move it around unless the
+	 * isolation mechanism requests to move it to an upcoming
+	 * housekeeping CPU.
 	 */
-	if (!irqd_is_single_target(data))
+	if (!irqd_is_single_target(data) || hk_should_isolate(data, cpu))
 		irq_set_affinity_locked(data, affinity, false);
 }
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b6c53ab..818b280 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
+#include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
 
@@ -217,7 +218,45 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	ret = chip->irq_set_affinity(data, mask, force);
+	/*
+	 * If this is a managed interrupt and housekeeping is enabled on
+	 * it check whether the requested affinity mask intersects with
+	 * a housekeeping CPU. If so, then remove the isolated CPUs from
+	 * the mask and just keep the housekeeping CPU(s). This prevents
+	 * the affinity setter from routing the interrupt to an isolated
+	 * CPU to avoid that I/O submitted from a housekeeping CPU causes
+	 * interrupts on an isolated one.
+	 *
+	 * If the masks do not intersect or include online CPU(s) then
+	 * keep the requested mask. The isolated target CPUs are only
+	 * receiving interrupts when the I/O operation was submitted
+	 * directly from them.
+	 *
+	 * If all housekeeping CPUs in the affinity mask are offline, the
+	 * interrupt will be migrated by the CPU hotplug code once a
+	 * housekeeping CPU which belongs to the affinity mask comes
+	 * online.
+	 */
+	if (irqd_affinity_is_managed(data) &&
+	    housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {
+		const struct cpumask *hk_mask, *prog_mask;
+
+		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
+		static struct cpumask tmp_mask;
+
+		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+
+		raw_spin_lock(&tmp_mask_lock);
+		cpumask_and(&tmp_mask, mask, hk_mask);
+		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
+			prog_mask = mask;
+		else
+			prog_mask = &tmp_mask;
+		ret = chip->irq_set_affinity(data, prog_mask, force);
+		raw_spin_unlock(&tmp_mask_lock);
+	} else {
+		ret = chip->irq_set_affinity(data, mask, force);
+	}
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 9fcb2a6..008d6ac 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -163,6 +163,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "managed_irq,", 12)) {
+			str += 12;
+			flags |= HK_FLAG_MANAGED_IRQ;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}
