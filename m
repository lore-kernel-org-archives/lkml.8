Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5383FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D20620866
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHYAYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:24:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:28306 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgHYAYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:24:43 -0400
IronPort-SDR: us6wapPcmaKvrmzKbsxCUTbSjMrsJ46W29QaiexIT5nhRE2VIn/W2LdYshMFHKmPdMMwx0KEAP
 A9ReP3gtF0bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143670238"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143670238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:24:41 -0700
IronPort-SDR: EDUiDsY5vD0yVv7yxAOaUPQeqP6sM8sTgqKY0a4u3eotGwg9AsRqjkBEUax+21fAbBlIFLsyyx
 3y/GocM9V0fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443428043"
Received: from huiyao-mobl2.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.214.197])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2020 17:24:36 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V3 1/5] autonuma: Optimize page placement for memory tiering system
Date:   Tue, 25 Aug 2020 08:23:50 +0800
Message-Id: <20200825002354.17038-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825002354.17038-1-ying.huang@intel.com>
References: <20200825002354.17038-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of various new memory types, some machines will have
multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
memory subsystem of these machines can be called memory tiering
system, because the performance of the different types of memory are
usually different.

In such system, because of the memory accessing pattern changing etc,
some pages in the slow memory may become hot globally.  So in this
patch, the AutoNUMA mechanism is enhanced to optimize the page
placement among the different memory types according to hot/cold
dynamically.

In a typical memory tiering system, there are CPUs, fast memory and
slow memory in each physical NUMA node.  The CPUs and the fast memory
will be put in one logical node (called fast memory node), while the
slow memory will be put in another (faked) logical node (called slow
memory node).  That is, the fast memory is regarded as local while the
slow memory is regarded as remote.  So it's possible for the recently
accessed pages in the slow memory node to be promoted to the fast
memory node via the existing AutoNUMA mechanism.

The original AutoNUMA mechanism will stop to migrate pages if the free
memory of the target node will become below the high watermark.  This
is a reasonable policy if there's only one memory type.  But this
makes the original AutoNUMA mechanism almost not work to optimize page
placement among different memory types.  Details are as follows.

It's the common cases that the working-set size of the workload is
larger than the size of the fast memory nodes.  Otherwise, it's
unnecessary to use the slow memory at all.  So in the common cases,
there are almost always no enough free pages in the fast memory nodes,
so that the globally hot pages in the slow memory node cannot be
promoted to the fast memory node.  To solve the issue, we have 2
choices as follows,

a. Ignore the free pages watermark checking when promoting hot pages
   from the slow memory node to the fast memory node.  This will
   create some memory pressure in the fast memory node, thus trigger
   the memory reclaiming.  So that, the cold pages in the fast memory
   node will be demoted to the slow memory node.

b. Make kswapd of the fast memory node to reclaim pages until the free
   pages are a little more (about 10MB) than the high watermark.  Then,
   if the free pages of the fast memory node reaches high watermark, and
   some hot pages need to be promoted, kswapd of the fast memory node
   will be waken up to demote some cold pages in the fast memory node to
   the slow memory node.  This will free some extra space in the fast
   memory node, so the hot pages in the slow memory node can be
   promoted to the fast memory node.

The choice "a" will create the memory pressure in the fast memory
node.  If the memory pressure of the workload is high, the memory
pressure may become so high that the memory allocation latency of the
workload is influenced, e.g. the direct reclaiming may be triggered.

The choice "b" works much better at this aspect.  If the memory
pressure of the workload is high, the hot pages promotion will stop
earlier because its allocation watermark is higher than that of the
normal memory allocation.  So in this patch, choice "b" is
implemented.

In addition to the original page placement optimization among sockets,
the AutoNUMA mechanism is extended to be used to optimize page
placement according to hot/cold among different memory types.  So the
sysctl user space interface (numa_balancing) is extended in a backward
compatible way as follow, so that the users can enable/disable these
functionality individually.

The sysctl is converted from a Boolean value to a bits field.  The
definition of the flags is,

- 0x0: NUMA_BALANCING_DISABLED
- 0x1: NUMA_BALANCING_NORMAL
- 0x2: NUMA_BALANCING_MEMORY_TIERING

TODO:

- Update ABI document: Documentation/sysctl/kernel.txt

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
 include/linux/sched/sysctl.h |  5 +++++
 kernel/sched/core.c          |  9 +++------
 kernel/sysctl.c              |  7 ++++---
 mm/migrate.c                 | 30 +++++++++++++++++++++++++++---
 mm/vmscan.c                  | 15 +++++++++++++++
 5 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49f2b53..bdd38045d14c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -39,6 +39,11 @@ enum sched_tunable_scaling {
 };
 extern enum sched_tunable_scaling sysctl_sched_tunable_scaling;
 
+#define NUMA_BALANCING_DISABLED		0x0
+#define NUMA_BALANCING_NORMAL		0x1
+#define NUMA_BALANCING_MEMORY_TIERING	0x2
+
+extern int sysctl_numa_balancing_mode;
 extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2142c6767682..dfbcd684fa40 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2794,6 +2794,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
+int sysctl_numa_balancing_mode;
 
 #ifdef CONFIG_NUMA_BALANCING
 
@@ -2809,20 +2810,16 @@ void set_numabalancing_state(bool enabled)
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table t;
 	int err;
-	int state = static_branch_likely(&sched_numa_balancing);
 
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	t = *table;
-	t.data = &state;
-	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (err < 0)
 		return err;
 	if (write)
-		set_numabalancing_state(state);
+		set_numabalancing_state(*(int *)table->data);
 	return err;
 }
 #endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7af2563..75a6d35bd22e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -113,6 +113,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
+static int __maybe_unused three = 3;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -1756,12 +1757,12 @@ static struct ctl_table kern_table[] = {
 	},
 	{
 		.procname	= "numa_balancing",
-		.data		= NULL, /* filled in by handler */
-		.maxlen		= sizeof(unsigned int),
+		.data		= &sysctl_numa_balancing_mode,
+		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &three,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
diff --git a/mm/migrate.c b/mm/migrate.c
index 11e10e72cf92..9c5aa588ea4f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/ptrace.h>
 #include <linux/oom.h>
 #include <linux/memory.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlbflush.h>
 
@@ -1954,13 +1955,36 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
-	int page_lru;
+	int page_lru, nr = compound_nr(page), order = compound_order(page);
 
-	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
+	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
+	if (!migrate_balanced_pgdat(pgdat, nr)) {
+		int migration_node, z;
+		pg_data_t *migration_pgdat;
+
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+		    !(node_reclaim_mode & RECLAIM_MIGRATE))
+			return 0;
+		/*
+		 * The slow memory node need to have enough
+		 * free pages to demote the cold pages in the
+		 * fast memory node to it.
+		 */
+		migration_node = next_demotion_node(pgdat->node_id);
+		if (migration_node == NUMA_NO_NODE)
+			return 0;
+		migration_pgdat = NODE_DATA(migration_node);
+		if (!migrate_balanced_pgdat(migration_pgdat, nr))
+			return 0;
+		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+			if (populated_zone(pgdat->node_zones + z))
+				break;
+		}
+		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
 		return 0;
+	}
 
 	if (isolate_lru_page(page))
 		return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index da80b98d6b57..c3544030764d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -58,6 +58,7 @@
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -3544,6 +3545,12 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
 	return false;
 }
 
+/*
+ * Keep the free pages on fast memory node a little more than the high
+ * watermark to accommodate the promoted pages.
+ */
+#define NUMA_BALANCING_ADDON_WATERMARK		(10UL * 1024 * 1024 >> PAGE_SHIFT)
+
 /*
  * Returns true if there is an eligible zone balanced for the request order
  * and highest_zoneidx
@@ -3565,6 +3572,14 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 			continue;
 
 		mark = high_wmark_pages(zone);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE) {
+			unsigned long addon_mark;
+
+			addon_mark = min(NUMA_BALANCING_ADDON_WATERMARK,
+					 pgdat->node_present_pages >> 6);
+			mark += addon_mark;
+		}
 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
 			return true;
 	}
-- 
2.27.0

