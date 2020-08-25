Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E667DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5365207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHYAY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:24:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:28306 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgHYAYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:24:53 -0400
IronPort-SDR: /XEaYfCiaJ27lo6+1zm1oDCdZvzxXprZYZLXJ6kG1o1VBzXpziR0jcTgZWKk8anaK1DywZP3o4
 gL2RXv6SIvbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143670273"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143670273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:24:53 -0700
IronPort-SDR: b/majW+c5YOTMnH5g0wmjUzSrjN+gK+tBojAPje3IwOWLSX5zI9+1IEQEC3Xt45uKbMxXFJQha
 rh/5yR/djoig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443428084"
Received: from huiyao-mobl2.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.214.197])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2020 17:24:49 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V3 4/5] autonuma, memory tiering: Rate limit NUMA migration throughput
Date:   Tue, 25 Aug 2020 08:23:53 +0800
Message-Id: <20200825002354.17038-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825002354.17038-1-ying.huang@intel.com>
References: <20200825002354.17038-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AutoNUMA memory tiering mode, the hot slow memory pages could be
promoted to the fast memory node via AutoNUMA.  But this incurs some
overhead too.  So that sometimes the workload performance may be hurt.
To avoid too much disturbing to the workload in these situations, we
should make it possible to rate limit the promotion throughput.

So, in this patch, we implement a simple rate limit algorithm as
follows.  The number of the candidate pages to be promoted to the fast
memory node via AutoNUMA is counted, if the count exceeds the limit
specified by the users, the AutoNUMA promotion will be stopped until
the next second.

Test the patch with the pmbench memory accessing benchmark with 80:20
read/write ratio and normal access address distribution on a 2 socket
Intel server with Optane DC Persistent Memory Model.  In the test, the
page promotion throughput decreases 49.4% (from 208.2 MB/s to 105.3
MB/s) with the patch, while the benchmark score decreases only 1.1%.

A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
the users to specify the limit.

TODO: Add ABI document for new sysctl knob.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h       |  7 +++++++
 include/linux/sched/sysctl.h |  6 ++++++
 kernel/sched/fair.c          | 29 +++++++++++++++++++++++++++--
 kernel/sysctl.c              |  8 ++++++++
 mm/vmstat.c                  |  3 +++
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f6f884970511..6e1e138cf61c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -203,6 +203,9 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
+#ifdef CONFIG_NUMA_BALANCING
+	NUMA_NR_CANDIDATE,	/* candidate pages to migrate */
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
@@ -746,6 +749,10 @@ typedef struct pglist_data {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned long numa_ts;
+	unsigned long numa_nr_candidate;
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
 	/*
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 435d66269d0a..40a3b6b3e0f8 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -50,6 +50,12 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 
+#ifdef CONFIG_NUMA_BALANCING
+extern unsigned int sysctl_numa_balancing_rate_limit;
+#else
+#define sysctl_numa_balancing_rate_limit	0
+#endif
+
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 62510b435a89..7835485e4b8a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1078,6 +1078,11 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
 /* The page with hint page fault latency < threshold in ms is considered hot */
 unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+/*
+ * Restrict the NUMA migration per second in MB for each target node
+ * if no enough free space in target node
+ */
+unsigned int sysctl_numa_balancing_rate_limit = 65536;
 
 struct numa_group {
 	refcount_t refcount;
@@ -1450,6 +1455,23 @@ static int numa_hint_fault_latency(struct page *page)
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
 
+static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
+					    unsigned long rate_limit, int nr)
+{
+	unsigned long nr_candidate;
+	unsigned long now = jiffies, last_ts;
+
+	mod_node_page_state(pgdat, NUMA_NR_CANDIDATE, nr);
+	nr_candidate = node_page_state(pgdat, NUMA_NR_CANDIDATE);
+	last_ts = pgdat->numa_ts;
+	if (now > last_ts + HZ &&
+	    cmpxchg(&pgdat->numa_ts, last_ts, now) == last_ts)
+		pgdat->numa_nr_candidate = nr_candidate;
+	if (nr_candidate - pgdat->numa_nr_candidate > rate_limit)
+		return false;
+	return true;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1464,7 +1486,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long latency, th;
+		unsigned long rate_limit, latency, th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1475,7 +1497,10 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		if (latency > th)
 			return false;
 
-		return true;
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		return numa_migration_check_rate_limit(pgdat, rate_limit,
+						       hpage_nr_pages(page));
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 69b93b1b20aa..62bccf75728c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1762,6 +1762,14 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "numa_balancing_rate_limit_mbps",
+		.data		= &sysctl_numa_balancing_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= &sysctl_numa_balancing_mode,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 84f68884e7d7..13adcdd4a0a8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1172,6 +1172,9 @@ const char * const vmstat_text[] = {
 	"nr_kernel_misc_reclaimable",
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
+#ifdef CONFIG_NUMA_BALANCING
+	"numa_nr_candidate",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.27.0

