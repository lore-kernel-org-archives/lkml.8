Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94190C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgBFTUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:20:15 -0500
Received: from foss.arm.com ([217.140.110.172]:33658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBFTUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:20:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B48E31B;
        Thu,  6 Feb 2020 11:20:13 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 286413F52E;
        Thu,  6 Feb 2020 11:20:12 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org,
        pkondeti@codeaurora.org
Subject: [PATCH v4 1/4] sched/fair: Add asymmetric CPU capacity wakeup scan
Date:   Thu,  6 Feb 2020 19:19:54 +0000
Message-Id: <20200206191957.12325-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200206191957.12325-1-valentin.schneider@arm.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

Issue
=====

On asymmetric CPU capacity topologies, we currently rely on wake_cap() to
drive select_task_rq_fair() towards either
- its slow-path (find_idlest_cpu()) if either the previous or
  current (waking) CPU has too little capacity for the waking task
- its fast-path (select_idle_sibling()) otherwise

Commit 3273163c6775 ("sched/fair: Let asymmetric CPU configurations balance
at wake-up") points out that this relies on the assumption that "[...]the
CPU capacities within an SD_SHARE_PKG_RESOURCES domain (sd_llc) are
homogeneous".

This assumption no longer holds on newer generations of big.LITTLE
systems (DynamIQ), which can accommodate CPUs of different compute capacity
within a single LLC domain. To hopefully paint a better picture, a regular
big.LITTLE topology would look like this:

  +---------+ +---------+
  |   L2    | |   L2    |
  +----+----+ +----+----+
  |CPU0|CPU1| |CPU2|CPU3|
  +----+----+ +----+----+
      ^^^         ^^^
    LITTLEs      bigs

which would result in the following scheduler topology:

  DIE [         ] <- sd_asym_cpucapacity
  MC  [   ] [   ] <- sd_llc
       0 1   2 3

Conversely, a DynamIQ topology could look like:

  +-------------------+
  |        L3         |
  +----+----+----+----+
  | L2 | L2 | L2 | L2 |
  +----+----+----+----+
  |CPU0|CPU1|CPU2|CPU3|
  +----+----+----+----+
     ^^^^^     ^^^^^
    LITTLEs    bigs

which would result in the following scheduler topology:

  MC [       ] <- sd_llc, sd_asym_cpucapacity
      0 1 2 3

What this means is that, on DynamIQ systems, we could pass the wake_cap()
test (IOW presume the waking task fits on the CPU capacities of some LLC
domain), thus go through select_idle_sibling().
This function operates on an LLC domain, which here spans both bigs and
LITTLEs, so it could very well pick a CPU of too small capacity for the
task, despite there being fitting idle CPUs - it very much depends on the
CPU iteration order, on which we have absolutely no guarantees
capacity-wise.

Implementation
==============

Introduce yet another select_idle_sibling() helper function that takes CPU
capacity into account. The policy is to pick the first idle CPU which is
big enough for the task (task_util * margin < cpu_capacity). If no
idle CPU is big enough, we pick the idle one with the highest capacity.

Unlike other select_idle_sibling() helpers, this one operates on the
sd_asym_cpucapacity sched_domain pointer, which is guaranteed to span all
known CPU capacities in the system. As such, this will work for both
"legacy" big.LITTLE (LITTLEs & bigs split at MC, joined at DIE) and for
newer DynamIQ systems (e.g. LITTLEs and bigs in the same MC domain).

Note that this limits the scope of select_idle_sibling() to
select_idle_capacity() for asymmetric CPU capacity systems - the LLC domain
will not be scanned, and no further heuristic will be applied.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Co-developed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4e0d7753756..9a5a6e9d2375e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5894,6 +5894,40 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+/*
+ * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
+ * the task fits. If no CPU is big enough, but there are idle ones, try to
+ * maximize capacity.
+ */
+static int
+select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	unsigned long best_cap = 0;
+	int cpu, best_cpu = -1;
+	struct cpumask *cpus;
+
+	sync_entity_load_avg(&p->se);
+
+	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
+	for_each_cpu_wrap(cpu, cpus, target) {
+		unsigned long cpu_cap = capacity_of(cpu);
+
+		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
+			continue;
+		if (task_fits_capacity(p, cpu_cap))
+			return cpu;
+
+		if (cpu_cap > best_cap) {
+			best_cap = cpu_cap;
+			best_cpu = cpu;
+		}
+	}
+
+	return best_cpu;
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -5902,6 +5936,28 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/*
+	 * For asymmetric CPU capacity systems, our domain of interest is
+	 * sd_asym_cpucapacity rather than sd_llc.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
+		/*
+		 * On an asymmetric CPU capacity system where an exclusive
+		 * cpuset defines a symmetric island (i.e. one unique
+		 * capacity_orig value through the cpuset), the key will be set
+		 * but the CPUs within that cpuset will not have a domain with
+		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
+		 * capacity path.
+		 */
+		if (!sd)
+			goto symmetric;
+
+		i = select_idle_capacity(p, sd, target);
+		return ((unsigned)i < nr_cpumask_bits) ? i : target;
+	}
+
+symmetric:
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
-- 
2.24.0

