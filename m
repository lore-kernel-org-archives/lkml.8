Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1702076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442335AbgDOVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:10:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442223AbgDOVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:05:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6B5511FB;
        Wed, 15 Apr 2020 14:05:27 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E27E3F6C4;
        Wed, 15 Apr 2020 14:05:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v3 3/9] sched: Remove checks against SD_LOAD_BALANCE
Date:   Wed, 15 Apr 2020 22:05:06 +0100
Message-Id: <20200415210512.805-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415210512.805-1-valentin.schneider@arm.com>
References: <20200415210512.805-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SD_LOAD_BALANCE flag is set unconditionally for all domains in
sd_init(). By making the sched_domain->flags syctl interface read-only, we
have removed the last piece of code that could clear that flag - as such,
it will now be always present. Rather than to keep carrying it along, we
can work towards getting rid of it entirely.

cpusets don't need it because they can make CPUs be attached to the NULL
domain (e.g. cpuset with sched_load_balance=0), or to a partitioned
root_domain, i.e. a sched_domain hierarchy that doesn't span the entire
system (e.g. root cpuset with sched_load_balance=0 and sibling cpusets with
sched_load_balance=1).

isolcpus apply the same "trick": isolated CPUs are explicitly taken out of
the sched_domain rebuild (using housekeeping_cpumask()), so they get the
NULL domain treatment as well.

Remove the checks against SD_LOAD_BALANCE.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c     | 14 ++------------
 kernel/sched/topology.c | 28 +++++++++-------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 98321d8dde7e..3d34b4e4060f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6645,9 +6645,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	rcu_read_lock();
 	for_each_domain(cpu, tmp) {
-		if (!(tmp->flags & SD_LOAD_BALANCE))
-			break;
-
 		/*
 		 * If both 'cpu' and 'prev_cpu' are part of this domain,
 		 * cpu is a valid SD_WAKE_AFFINE target.
@@ -9792,9 +9789,8 @@ static int active_load_balance_cpu_stop(void *data)
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
@@ -9883,9 +9879,6 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 		max_cost += sd->max_newidle_lb_cost;
 
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
 		/*
 		 * Stop the load balance at this level. There is another
 		 * CPU in our sched group which is doing load balancing more
@@ -10474,9 +10467,6 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 t0, domain_cost;
 
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
 			update_next_balance(sd, &next_balance);
 			break;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757bba6e..a9dc34a0ebc1 100644
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

