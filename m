Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F9C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7DC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgA2Ldl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgA2LdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlah-0007nm-3y; Wed, 29 Jan 2020 12:33:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 12F1D1C1C1C;
        Wed, 29 Jan 2020 12:33:00 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:59 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Allow a small load imbalance between
 low utilisation SD_NUMA domains
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200114101319.GO3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158029757986.396.4611669971159401987.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: 1.5
X-Linutronix-Spam-Level: +
X-Linutronix-Spam-Status: No , 1.5 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_DBL_ABUSE_MALW=2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b396f52326de20ec974471b7b19168867b365cbf
Gitweb:        https://git.kernel.org/tip/b396f52326de20ec974471b7b19168867b365cbf
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 14 Jan 2020 10:13:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:36:55 +01:00

sched/fair: Allow a small load imbalance between low utilisation SD_NUMA domains

The CPU load balancer balances between different domains to spread load
and strives to have equal balance everywhere. Communicating tasks can
migrate so they are topologically close to each other but these decisions
are independent. On a lightly loaded NUMA machine, two communicating tasks
pulled together at wakeup time can be pushed apart by the load balancer.
In isolation, the load balancer decision is fine but it ignores the tasks
data locality and the wakeup/LB paths continually conflict. NUMA balancing
is also a factor but it also simply conflicts with the load balancer.

This patch allows a fixed degree of imbalance of two tasks to exist
between NUMA domains regardless of utilisation levels. In many cases,
this prevents communicating tasks being pulled apart. It was evaluated
whether the imbalance should be scaled to the domain size. However, no
additional benefit was measured across a range of workloads and machines
and scaling adds the risk that lower domains have to be rebalanced. While
this could change again in the future, such a change should specify the
use case and benefit.

The most obvious impact is on netperf TCP_STREAM -- two simple
communicating tasks with some softirq offload depending on the
transmission rate.

 2-socket Haswell machine 48 core, HT enabled
 netperf-tcp -- mmtests config config-network-netperf-unbound
			      baseline              lbnuma-v3
 Hmean     64         568.73 (   0.00%)      577.56 *   1.55%*
 Hmean     128       1089.98 (   0.00%)     1128.06 *   3.49%*
 Hmean     256       2061.72 (   0.00%)     2104.39 *   2.07%*
 Hmean     1024      7254.27 (   0.00%)     7557.52 *   4.18%*
 Hmean     2048     11729.20 (   0.00%)    13350.67 *  13.82%*
 Hmean     3312     15309.08 (   0.00%)    18058.95 *  17.96%*
 Hmean     4096     17338.75 (   0.00%)    20483.66 *  18.14%*
 Hmean     8192     25047.12 (   0.00%)    27806.84 *  11.02%*
 Hmean     16384    27359.55 (   0.00%)    33071.88 *  20.88%*
 Stddev    64           2.16 (   0.00%)        2.02 (   6.53%)
 Stddev    128          2.31 (   0.00%)        2.19 (   5.05%)
 Stddev    256         11.88 (   0.00%)        3.22 (  72.88%)
 Stddev    1024        23.68 (   0.00%)        7.24 (  69.43%)
 Stddev    2048        79.46 (   0.00%)       71.49 (  10.03%)
 Stddev    3312        26.71 (   0.00%)       57.80 (-116.41%)
 Stddev    4096       185.57 (   0.00%)       96.15 (  48.19%)
 Stddev    8192       245.80 (   0.00%)      100.73 (  59.02%)
 Stddev    16384      207.31 (   0.00%)      141.65 (  31.67%)

In this case, there was a sizable improvement to performance and
a general reduction in variance. However, this is not univeral.
For most machines, the impact was roughly a 3% performance gain.

 Ops NUMA base-page range updates       19796.00         292.00
 Ops NUMA PTE updates                   19796.00         292.00
 Ops NUMA PMD updates                       0.00           0.00
 Ops NUMA hint faults                   16113.00         143.00
 Ops NUMA hint local faults %            8407.00         142.00
 Ops NUMA hint local percent               52.18          99.30
 Ops NUMA pages migrated                 4244.00           1.00

Without the patch, only 52.18% of sampled accesses are local.  In an
earlier changelog, 100% of sampled accesses are local and indeed on
most machines, this was still the case. In this specific case, the
local sampled rates was 99.3% but note the "base-page range updates"
and "PTE updates".  The activity with the patch is negligible as were
the number of faults. The small number of pages migrated were related to
shared libraries.  A 2-socket Broadwell showed better results on average
but are not presented for brevity as the performance was similar except
it showed 100% of the sampled NUMA hints were local. The patch holds up
for a 4-socket Haswell, an AMD EPYC and AMD Epyc 2 machine.

For dbench, the impact depends on the filesystem used and the number of
clients. On XFS, there is little difference as the clients typically
communicate with workqueues which have a separate class of scheduler
problem at the moment. For ext4, performance is generally better,
particularly for small numbers of clients as NUMA balancing activity is
negligible with the patch applied.

A more interesting example is the Facebook schbench which uses a
number of messaging threads to communicate with worker threads. In this
configuration, one messaging thread is used per NUMA node and the number of
worker threads is varied. The 50, 75, 90, 95, 99, 99.5 and 99.9 percentiles
for response latency is then reported.

 Lat 50.00th-qrtle-1        44.00 (   0.00%)       37.00 (  15.91%)
 Lat 75.00th-qrtle-1        53.00 (   0.00%)       41.00 (  22.64%)
 Lat 90.00th-qrtle-1        57.00 (   0.00%)       42.00 (  26.32%)
 Lat 95.00th-qrtle-1        63.00 (   0.00%)       43.00 (  31.75%)
 Lat 99.00th-qrtle-1        76.00 (   0.00%)       51.00 (  32.89%)
 Lat 99.50th-qrtle-1        89.00 (   0.00%)       52.00 (  41.57%)
 Lat 99.90th-qrtle-1        98.00 (   0.00%)       55.00 (  43.88%)
 Lat 50.00th-qrtle-2        42.00 (   0.00%)       42.00 (   0.00%)
 Lat 75.00th-qrtle-2        48.00 (   0.00%)       47.00 (   2.08%)
 Lat 90.00th-qrtle-2        53.00 (   0.00%)       52.00 (   1.89%)
 Lat 95.00th-qrtle-2        55.00 (   0.00%)       53.00 (   3.64%)
 Lat 99.00th-qrtle-2        62.00 (   0.00%)       60.00 (   3.23%)
 Lat 99.50th-qrtle-2        63.00 (   0.00%)       63.00 (   0.00%)
 Lat 99.90th-qrtle-2        68.00 (   0.00%)       66.00 (   2.94%

For higher worker threads, the differences become negligible but it's
interesting to note the difference in wakeup latency at low utilisation
and mpstat confirms that activity was almost all on one node until
the number of worker threads increase.

Hackbench generally showed neutral results across a range of machines.
This is different to earlier versions of the patch which allowed imbalances
for higher degrees of utilisation. perf bench pipe showed negligible
differences in overall performance as the differences are very close to
the noise.

An earlier prototype of the patch showed major regressions for NAS C-class
when running with only half of the available CPUs -- 20-30% performance
hits were measured at the time. With this version of the patch, the impact
is negligible with small gains/losses within the noise measured. This is
because the number of threads far exceeds the small imbalance the aptch
cares about. Similarly, there were report of regressions for the autonuma
benchmark against earlier versions but again, normal load balancing now
applies for that workload.

In general, the patch simply seeks to avoid unnecessary cross-node
migrations in the basic case where imbalances are very small.  For low
utilisation communicating workloads, this patch generally behaves better
with less NUMA balancing activity. For high utilisation, there is no
change in behaviour.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Phil Auld <pauld@redhat.com>
Tested-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200114101319.GO3466@techsingularity.net
---
 kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4e0d7..25dffc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8658,10 +8658,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	/*
 	 * Try to use spare capacity of local group without overloading it or
 	 * emptying busiest.
-	 * XXX Spreading tasks across NUMA nodes is not always the best policy
-	 * and special care should be taken for SD_NUMA domain level before
-	 * spreading the tasks. For now, load_balance() fully relies on
-	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {
@@ -8701,16 +8697,37 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
-			return;
-		}
+		} else {
 
-		/*
-		 * If there is no overload, we just want to even the number of
-		 * idle cpus.
-		 */
-		env->migration_type = migrate_task;
-		env->imbalance = max_t(long, 0, (local->idle_cpus -
+			/*
+			 * If there is no overload, we just want to even the number of
+			 * idle cpus.
+			 */
+			env->migration_type = migrate_task;
+			env->imbalance = max_t(long, 0, (local->idle_cpus -
 						 busiest->idle_cpus) >> 1);
+		}
+
+		/* Consider allowing a small imbalance between NUMA groups */
+		if (env->sd->flags & SD_NUMA) {
+			unsigned int imbalance_min;
+
+			/*
+			 * Compute an allowed imbalance based on a simple
+			 * pair of communicating tasks that should remain
+			 * local and ignore them.
+			 *
+			 * NOTE: Generally this would have been based on
+			 * the domain size and this was evaluated. However,
+			 * the benefit is similar across a range of workloads
+			 * and machines but scaling by the domain size adds
+			 * the risk that lower domains have to be rebalanced.
+			 */
+			imbalance_min = 2;
+			if (busiest->sum_nr_running <= imbalance_min)
+				env->imbalance = 0;
+		}
+
 		return;
 	}
 
