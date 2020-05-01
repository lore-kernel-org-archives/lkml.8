Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9AAC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC3B24967
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgEASYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730587AbgEASWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC5C061A0C;
        Fri,  1 May 2020 11:22:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIh-0003Z3-Ok; Fri, 01 May 2020 20:22:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 61D1F1C048C;
        Fri,  1 May 2020 20:22:10 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:10 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove checks against SD_LOAD_BALANCE
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415210512.805-4-valentin.schneider@arm.com>
References: <20200415210512.805-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158835733033.8414.9767037933834526210.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e669ac8ab952df2f07dee1e1efbf40647d6de332
Gitweb:        https://git.kernel.org/tip/e669ac8ab952df2f07dee1e1efbf40647d6de332
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 15 Apr 2020 22:05:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:39 +02:00

sched: Remove checks against SD_LOAD_BALANCE

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200415210512.805-4-valentin.schneider@arm.com
---
 kernel/sched/fair.c     | 14 ++------------
 kernel/sched/topology.c | 28 +++++++++-------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 617ca44..4b959c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6649,9 +6649,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	rcu_read_lock();
 	for_each_domain(cpu, tmp) {
-		if (!(tmp->flags & SD_LOAD_BALANCE))
-			break;
-
 		/*
 		 * If both 'cpu' and 'prev_cpu' are part of this domain,
 		 * cpu is a valid SD_WAKE_AFFINE target.
@@ -9790,9 +9787,8 @@ static int active_load_balance_cpu_stop(void *data)
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
@@ -9881,9 +9877,6 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 		max_cost += sd->max_newidle_lb_cost;
 
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
 		/*
 		 * Stop the load balance at this level. There is another
 		 * CPU in our sched group which is doing load balancing more
@@ -10472,9 +10465,6 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 t0, domain_cost;
 
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
 			update_next_balance(sd, &next_balance);
 			break;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757..a9dc34a 100644
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
