Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99800C34035
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CAF206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBRI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:27:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:18962 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgBRI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="235466657"
Received: from yhuang-dev.sh.intel.com ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 00:27:18 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V2 2/8] autonuma, memory tiering: Rate limit NUMA migration throughput
Date:   Tue, 18 Feb 2020 16:26:28 +0800
Message-Id: <20200218082634.1596727-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218082634.1596727-1-ying.huang@intel.com>
References: <20200218082634.1596727-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In autonuma memory tiering mode, the hot PMEM (persistent memory)
pages could be migrated to DRAM via autonuma.  But this incurs some
overhead too.  So that sometimes the workload performance may be hurt.
To avoid too much disturbing to the workload, the migration throughput
should be rate-limited.

At the other hand, in some situation, for example, some workloads
exits, many DRAM pages become free, so that some pages of the other
workloads can be migrated to DRAM.  To respond to the workloads
changing quickly, it's better to migrate pages faster.

To address the above 2 requirements, a rate limit algorithm as follows
is used,

- If there is enough free memory in DRAM node (that is, > high
  watermark + 2 * rate limit pages), then NUMA migration throughput will
  not be rate-limited to respond to the workload changing quickly.

- Otherwise, counting the number of pages to try to migrate to a DRAM
  node via autonuma, if the count exceeds the limit specified by the
  users, stop NUMA migration until the next second.

A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
the users to specify the limit.  If its value is 0, the default
value (high watermark) will be used.

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
 include/linux/mmzone.h       |  7 ++++
 include/linux/sched/sysctl.h |  6 ++++
 kernel/sched/fair.c          | 62 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              |  8 +++++
 mm/vmstat.c                  |  3 ++
 5 files changed, 86 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index dfb09106ad70..6e7a28becdc2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -249,6 +249,9 @@ enum node_stat_item {
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
+#ifdef CONFIG_NUMA_BALANCING
+	NUMA_TRY_MIGRATE,	/* pages to try to migrate via NUMA balancing */
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
@@ -786,6 +789,10 @@ typedef struct pglist_data {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned long numa_ts;
+	unsigned long numa_try;
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
 	/*
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 80dc5030c797..c4b27790b901 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -43,6 +43,12 @@ extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 
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
index ba749f579714..ef694816150b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1064,6 +1064,12 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/*
+ * Restrict the NUMA migration per second in MB for each target node
+ * if no enough free space in target node
+ */
+unsigned int sysctl_numa_balancing_rate_limit;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1404,6 +1410,43 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 	return 1000 * faults / total_faults;
 }
 
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long rate_limit;
+
+	rate_limit = sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      high_wmark_pages(zone) + rate_limit * 2,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
+					    unsigned long rate_limit, int nr)
+{
+	unsigned long try;
+	unsigned long now = jiffies, last_ts;
+
+	mod_node_page_state(pgdat, NUMA_TRY_MIGRATE, nr);
+	try = node_page_state(pgdat, NUMA_TRY_MIGRATE);
+	last_ts = pgdat->numa_ts;
+	if (now > last_ts + HZ &&
+	    cmpxchg(&pgdat->numa_ts, last_ts, now) == last_ts)
+		pgdat->numa_try = try;
+	if (try - pgdat->numa_try > rate_limit)
+		return false;
+	return true;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1411,6 +1454,25 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * If memory tiering mode is enabled, will try promote pages
+	 * in slow memory node to fast memory node.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    next_promotion_node(src_nid) != -1) {
+		struct pglist_data *pgdat;
+		unsigned long rate_limit;
+
+		pgdat = NODE_DATA(dst_nid);
+		if (pgdat_free_space_enough(pgdat))
+			return true;
+
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		return numa_migration_check_rate_limit(pgdat, rate_limit,
+						       hpage_nr_pages(page));
+	}
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3756108bb658..2d19e821267a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -419,6 +419,14 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
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
index d76714d2fd7c..9326512c612c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1203,6 +1203,9 @@ const char * const vmstat_text[] = {
 	"nr_dirtied",
 	"nr_written",
 	"nr_kernel_misc_reclaimable",
+#ifdef CONFIG_NUMA_BALANCING
+	"numa_try_migrate",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.24.1

