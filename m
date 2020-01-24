Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4548BC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53A20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbgAXNDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:03:48 -0500
Received: from foss.arm.com ([217.140.110.172]:51444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbgAXNDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:03:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDBD61007;
        Fri, 24 Jan 2020 05:03:44 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A2E03F68E;
        Fri, 24 Jan 2020 05:03:43 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: [PATCH v2 1/3] sched/fair: Add asymmetric CPU capacity wakeup scan
Date:   Fri, 24 Jan 2020 13:02:11 +0000
Message-Id: <20200124130213.24886-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200124130213.24886-1-valentin.schneider@arm.com>
References: <20200124130213.24886-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

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

Introduce yet another select_idle_sibling() helper function that takes CPU
capacity into account. The policy is basically to pick the first idle CPU
which is big enough for the task (task_util * margin < cpu_capacity).

Unlike other select_idle_sibling() helpers, this one operates on the
sd_asym_cpucapacity sched_domain pointer, which is guaranteed to span all
known CPU capacities in the system. As such, this will work for both
"legacy" big.LITTLE (LITTLEs & bigs split at MC, joined at DIE) and for
newer DynamIQ systems (e.g. LITTLEs and bigs in the same MC domain).

Co-authored-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4e0d7753756..c44b135f61ad0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5894,6 +5894,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+/*
+ * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
+ * the task fits.
+ */
+static int select_idle_capacity(struct task_struct *p, int target)
+{
+	struct sched_domain *sd;
+	struct cpumask *cpus;
+	int cpu;
+
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return -1;
+
+	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
+	if (!sd)
+		return -1;
+
+	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
+	for_each_cpu_wrap(cpu, cpus, target) {
+		if (!available_idle_cpu(cpu))
+			continue;
+		if (!task_fits_capacity(p, capacity_of(cpu)))
+			continue;
+
+		return cpu;
+	}
+
+	return -1;
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -5902,6 +5934,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/* For asymmetric capacities, try to be smart about the placement */
+	i = select_idle_capacity(p, target);
+	if ((unsigned)i < nr_cpumask_bits)
+		return i;
+
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
-- 
2.24.0

