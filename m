Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC9C4CEC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1ED2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgCKSQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:16:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbgCKSQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:16:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E87FEC;
        Wed, 11 Mar 2020 11:16:55 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E5313F6CF;
        Wed, 11 Mar 2020 11:16:54 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v2 3/9] sched: Remove checks against SD_LOAD_BALANCE
Date:   Wed, 11 Mar 2020 18:15:55 +0000
Message-Id: <20200311181601.18314-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Potential users of that flag could have been cpusets and isolcpus.

cpusets don't need it because they define exclusive (i.e. non-overlapping)
domain spans, see cpuset.cpu_exclusive and cpuset.sched_load_balance.
If such a cpuset contains a single CPU, it will have the NULL domain
attached to it. If it contains several CPUs, none of their domains will
extend beyond the span of the cpuset.

isolcpus apply the same "trick": isolated CPUs are explicitly taken out of
the sched_domain rebuild (using housekeeping_cpumask()), so they get the
NULL domain treatment as well.

The sched_domain systcl interface was the only way to clear that flag, and
it has just been made read-only. Since sd_init() sets it unconditionally,
remove the checks.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c     | 14 ++------------
 kernel/sched/topology.c | 28 +++++++++-------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c3311277fb3..f8eb950fbefd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6609,9 +6609,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	rcu_read_lock();
 	for_each_domain(cpu, tmp) {
-		if (!(tmp->flags & SD_LOAD_BALANCE))
-			break;
-
 		/*
 		 * If both 'cpu' and 'prev_cpu' are part of this domain,
 		 * cpu is a valid SD_WAKE_AFFINE target.
@@ -9723,9 +9720,8 @@ static int active_load_balance_cpu_stop(void *data)
 	/* Search for an sd spanning us and the target CPU. */
 	rcu_read_lock();
 	for_each_domain(target_cpu, sd) {
-		if ((sd->flags & SD_LOAD_BALANCE) &&
-		    cpumask_test_cpu(busiest_cpu, sched_domain_span(sd)))
-				break;
+		if (cpumask_test_cpu(busiest_cpu, sched_domain_span(sd)))
+			break;
 	}
 
 	if (likely(sd)) {
@@ -9814,9 +9810,6 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 		max_cost += sd->max_newidle_lb_cost;
 
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
 		/*
 		 * Stop the load balance at this level. There is another
 		 * CPU in our sched group which is doing load balancing more
@@ -10405,9 +10398,6 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 t0, domain_cost;
 
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
 			update_next_balance(sd, &next_balance);
 			break;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 00911884b7e7..79a85827be2f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -33,14 +33,6 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 	cpumask_clear(groupmask);
 
 	printk(KERN_DEBUG "%*s domain-%d: ", level, "", level);
-
-	if (!(sd->flags & SD_LOAD_BALANCE)) {
-		printk("does not load-balance\n");
-		if (sd->parent)
-			printk(KERN_ERR "ERROR: !SD_LOAD_BALANCE domain has parent");
-		return -1;
-	}
-
 	printk(KERN_CONT "span=%*pbl level=%s\n",
 	       cpumask_pr_args(sched_domain_span(sd)), sd->name);
 
@@ -151,8 +143,7 @@ static int sd_degenerate(struct sched_domain *sd)
 		return 1;
 
 	/* Following flags need at least 2 groups */
-	if (sd->flags & (SD_LOAD_BALANCE |
-			 SD_BALANCE_NEWIDLE |
+	if (sd->flags & (SD_BALANCE_NEWIDLE |
 			 SD_BALANCE_FORK |
 			 SD_BALANCE_EXEC |
 			 SD_SHARE_CPUCAPACITY |
@@ -183,15 +174,14 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next) {
-		pflags &= ~(SD_LOAD_BALANCE |
-				SD_BALANCE_NEWIDLE |
-				SD_BALANCE_FORK |
-				SD_BALANCE_EXEC |
-				SD_ASYM_CPUCAPACITY |
-				SD_SHARE_CPUCAPACITY |
-				SD_SHARE_PKG_RESOURCES |
-				SD_PREFER_SIBLING |
-				SD_SHARE_POWERDOMAIN);
+		pflags &= ~(SD_BALANCE_NEWIDLE |
+			    SD_BALANCE_FORK |
+			    SD_BALANCE_EXEC |
+			    SD_ASYM_CPUCAPACITY |
+			    SD_SHARE_CPUCAPACITY |
+			    SD_SHARE_PKG_RESOURCES |
+			    SD_PREFER_SIBLING |
+			    SD_SHARE_POWERDOMAIN);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
-- 
2.24.0

