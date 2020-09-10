Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CFA20758
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIKPqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:46:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:22606 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgIKPo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:44:29 -0400
IronPort-SDR: en5OP5hLpm5gZe+nakhlzsdCPWidqPeqcRSUNXqovSXIiUiIrVRO4Oon39PmCVjVcEqD6H8Lhp
 Rj/31RpzsbpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146483413"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="146483413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 06:28:29 -0700
IronPort-SDR: WEUbiZZI3ak86hu9e5/kTXYW/2GEu/sbCQDWTGYexAARUGDEcvKGAHAzBJ1IanVuwJ6q1IFwGq
 Q79oOGiuvs0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="408157988"
Received: from aubrey-work.sh.intel.com ([10.239.53.113])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2020 06:28:26 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com
Cc:     tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask in sched domain
Date:   Thu, 10 Sep 2020 13:42:03 +0800
Message-Id: <20200910054203.525420-2-aubrey.li@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910054203.525420-1-aubrey.li@intel.com>
References: <20200910054203.525420-1-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added idle cpumask to track idle cpus in sched domain. When a CPU
enters idle, its corresponding bit in the idle cpumask will be set,
and when the CPU exits idle, its bit will be cleared.

When a task wakes up to select an idle cpu, scanning idle cpumask
has low cost than scanning all the cpus in last level cache domain,
especially when the system is heavily loaded.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 include/linux/sched/topology.h | 13 +++++++++++++
 kernel/sched/fair.c            |  4 +++-
 kernel/sched/topology.c        |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091129b3..43a641d26154 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -65,8 +65,21 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	/*
+	 * Span of all idle CPUs in this domain.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long	idle_cpus_span[];
 };
 
+static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->idle_cpus_span);
+}
+
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b3b59cc51d6..3b6f8a3589be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6136,7 +6136,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
@@ -10182,6 +10182,7 @@ static void set_cpu_sd_state_busy(int cpu)
 	sd->nohz_idle = 0;
 
 	atomic_inc(&sd->shared->nr_busy_cpus);
+	cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
 unlock:
 	rcu_read_unlock();
 }
@@ -10212,6 +10213,7 @@ static void set_cpu_sd_state_idle(int cpu)
 	sd->nohz_idle = 1;
 
 	atomic_dec(&sd->shared->nr_busy_cpus);
+	cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
 unlock:
 	rcu_read_unlock();
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9079d865a935..92d0aeef86bf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1769,7 +1769,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.25.1

