Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA9C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EE320838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHYAYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:24:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:28306 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgHYAYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:24:50 -0400
IronPort-SDR: ZLRl6ngt5ZY5r5z7TxaQHAIeB9PRxJ7WGVis3EvOzplKHD8Ew6Wudcv/Fwvk+10Y6h/+uJpeis
 OV0qOyFBE7+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143670263"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143670263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:24:49 -0700
IronPort-SDR: OXvxewSZ0AW+H04nzzd+EOFXoSQFKoGoY9qlYYUrW2WyCV/SrTzhBAg0K9y1Jbo5Erle6UhgmJ
 HvBcxOGmXh5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443428059"
Received: from huiyao-mobl2.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.214.197])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2020 17:24:45 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V3 3/5] autonuma, memory tiering: Hot page selection with hint page fault latency
Date:   Tue, 25 Aug 2020 08:23:52 +0800
Message-Id: <20200825002354.17038-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825002354.17038-1-ying.huang@intel.com>
References: <20200825002354.17038-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To optimize page placement in a memory tiering system with AutoNUMA,
the hot pages in the slow memory node need to be identified.
Essentially, the original AutoNUMA implementation selects the mostly
recently accessed (MRU) pages as the hot pages.  But this isn't a very
good algorithm to identify the hot pages.

So, in this patch we implemented a better hot page selection
algorithm.  Which is based on AutoNUMA page table scanning and hint
page fault as follows,

- When the page tables of the processes are scanned to change PTE/PMD
  to be PROT_NONE, the current time is recorded in struct page as scan
  time.

- When the page is accessed, hint page fault will occur.  The scan
  time is gotten from the struct page.  And The hint page fault
  latency is defined as

    hint page fault time - scan time

The shorter the hint page fault latency of a page is, the higher the
probability of their access frequency to be higher.  So the hint page
fault latency is a good estimation of the page hot/cold.

But it's hard to find some extra space in struct page to hold the scan
time.  Fortunately, we can reuse some bits used by the original
AutoNUMA.

AutoNUMA uses some bits in struct page to store the page accessing CPU
and PID (referring to page_cpupid_xchg_last()).  Which is used by the
multi-stage node selection algorithm to avoid to migrate pages shared
accessed by the NUMA nodes back and forth.  But for pages in the slow
memory node, even if they are shared accessed by multiple NUMA nodes,
as long as the pages are hot, they need to be promoted to the fast
memory node.  So the accessing CPU and PID information are unnecessary
for the slow memory pages.  We can reuse these bits in struct page to
record the scan time for them.  For the fast memory pages, these bits
are used as before.

The remaining problem is how to determine the hot threshold.  It's not
easy to be done automatically.  So we provide a sysctl knob:
kernel.numa_balancing_hot_threshold_ms.  All pages with hint page
fault latency < the threshold will be considered hot.  The system
administrator can determine the hot threshold via various information,
such as PMEM bandwidth limit, the average number of the pages pass the
hot threshold, etc.  The default hot threshold is 1 second, which
works well in our performance test.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
16.8% with 41.1% less pages promoted (that is, less overhead) on a 2
socket Intel server with Optance DC Persistent Memory.

The downside of the patch is that the response time to the workload
hot spot changing may be much longer.  For example,

- A previous cold memory area becomes hot

- The hint page fault will be triggered.  But the hint page fault
  latency isn't shorter than the hot threshold.  So the pages will
  not be promoted.

- When the memory area is scanned again, maybe after a scan period,
  the hint page fault latency measured will be shorter than the hot
  threshold and the pages will be promoted.

To mitigate this,

- If there are enough free space in the fast memory node, the hot
  threshold will not be used, all pages will be promoted upon the hint
  page fault for fast response.

- If fast response is more important for system performance, the
  administrator can set a higher hot threshold.

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
 include/linux/mm.h           | 29 ++++++++++++++++
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/fair.c          | 67 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              |  7 ++++
 mm/huge_memory.c             | 13 +++++--
 mm/memory.c                  | 11 +++++-
 mm/migrate.c                 | 12 +++++++
 mm/mmzone.c                  | 17 +++++++++
 mm/mprotect.c                |  8 ++++-
 9 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..0eac5049c153 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1278,6 +1278,18 @@ static inline int page_to_nid(const struct page *page)
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
+/* page access time bits needs to hold at least 4 seconds */
+#define PAGE_ACCESS_TIME_MIN_BITS	12
+#if LAST_CPUPID_SHIFT < PAGE_ACCESS_TIME_MIN_BITS
+#define	PAGE_ACCESS_TIME_BUCKETS				\
+	(PAGE_ACCESS_TIME_MIN_BITS - LAST_CPUPID_SHIFT)
+#else
+#define	PAGE_ACCESS_TIME_BUCKETS	0
+#endif
+
+#define PAGE_ACCESS_TIME_MASK				\
+	(LAST_CPUPID_MASK << PAGE_ACCESS_TIME_BUCKETS)
+
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
 	return ((cpu & LAST__CPU_MASK) << LAST__PID_SHIFT) | (pid & LAST__PID_MASK);
@@ -1320,6 +1332,16 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
 }
 
+static inline unsigned int xchg_page_access_time(struct page *page,
+						 unsigned int time)
+{
+	unsigned int last_time;
+
+	last_time = xchg(&page->_last_cpupid,
+			 (time >> PAGE_ACCESS_TIME_BUCKETS) & LAST_CPUPID_MASK);
+	return last_time << PAGE_ACCESS_TIME_BUCKETS;
+}
+
 static inline int page_cpupid_last(struct page *page)
 {
 	return page->_last_cpupid;
@@ -1335,6 +1357,7 @@ static inline int page_cpupid_last(struct page *page)
 }
 
 extern int page_cpupid_xchg_last(struct page *page, int cpupid);
+extern unsigned int xchg_page_access_time(struct page *page, unsigned int time);
 
 static inline void page_cpupid_reset_last(struct page *page)
 {
@@ -1347,6 +1370,12 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return page_to_nid(page); /* XXX */
 }
 
+static inline unsigned int xchg_page_access_time(struct page *page,
+						 unsigned int time)
+{
+	return 0;
+}
+
 static inline int page_cpupid_last(struct page *page)
 {
 	return page_to_nid(page); /* XXX */
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index bdd38045d14c..435d66269d0a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -48,6 +48,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..62510b435a89 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1076,6 +1076,9 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1416,6 +1419,37 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 	return 1000 * faults / total_faults;
 }
 
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long enough_mark;
+
+	enough_mark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
+			  pgdat->node_present_pages >> 4);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      high_wmark_pages(zone) + enough_mark,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+static int numa_hint_fault_latency(struct page *page)
+{
+	unsigned int last_time, time;
+
+	time = jiffies_to_msecs(jiffies);
+	last_time = xchg_page_access_time(page, time);
+
+	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1423,6 +1457,27 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * The pages in slow memory node should be migrated according
+	 * to hot/cold instead of accessing CPU node.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    !node_is_toptier(src_nid)) {
+		struct pglist_data *pgdat;
+		unsigned long latency, th;
+
+		pgdat = NODE_DATA(dst_nid);
+		if (pgdat_free_space_enough(pgdat))
+			return true;
+
+		th = sysctl_numa_balancing_hot_threshold;
+		latency = numa_hint_fault_latency(page);
+		if (latency > th)
+			return false;
+
+		return true;
+	}
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
@@ -2636,6 +2691,11 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	if (!p->mm)
 		return;
 
+	/* Numa faults statistics are unnecessary for the slow memory node */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    !node_is_toptier(mem_node))
+		return;
+
 	/* Allocate buffer to track faults on a per-node basis */
 	if (unlikely(!p->numa_faults)) {
 		int size = sizeof(*p->numa_faults) *
@@ -2655,6 +2715,13 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	 */
 	if (unlikely(last_cpupid == (-1 & LAST_CPUPID_MASK))) {
 		priv = 1;
+	} else if (unlikely(!cpu_online(cpupid_to_cpu(last_cpupid)))) {
+		/*
+		 * In memory tiering mode, cpupid of slow memory page is
+		 * used to record page access time, so its value may be
+		 * invalid during numa balancing mode transition.
+		 */
+		return;
 	} else {
 		priv = cpupid_match_pid(p, last_cpupid);
 		if (!priv && !(flags & TNF_NO_GROUP))
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 75a6d35bd22e..69b93b1b20aa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1755,6 +1755,13 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "numa_balancing_hot_threshold_ms",
+		.data		= &sysctl_numa_balancing_hot_threshold,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= &sysctl_numa_balancing_mode,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7d5db965a48c..7be0398dc973 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1399,7 +1399,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int page_nid = NUMA_NO_NODE, this_nid = numa_node_id();
-	int target_nid, last_cpupid = -1;
+	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool page_locked;
 	bool migrated = false;
 	bool was_writable;
@@ -1426,7 +1426,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	page = pmd_page(pmd);
 	BUG_ON(is_huge_zero_page(page));
 	page_nid = page_to_nid(page);
-	last_cpupid = page_cpupid_last(page);
+	if (node_is_toptier(page_nid))
+		last_cpupid = page_cpupid_last(page);
 	count_vm_numa_event(NUMA_HINT_FAULTS);
 	if (page_nid == this_nid) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
@@ -1824,6 +1825,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (prot_numa) {
 		struct page *page;
+		bool toptier;
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
 		 * data is likely to be read-cached on the local CPU and
@@ -1836,13 +1838,18 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			goto unlock;
 
 		page = pmd_page(*pmd);
+		toptier = node_is_toptier(page_to_nid(page));
 		/*
 		 * Skip scanning top tier node if normal numa
 		 * balancing is disabled
 		 */
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-		    node_is_toptier(page_to_nid(page)))
+		    toptier)
 			goto unlock;
+
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !toptier)
+			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/memory.c b/mm/memory.c
index 3ecad55103ad..69d416b88a09 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,7 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/sched/sysctl.h>
 
 #include <trace/events/kmem.h>
 
@@ -4077,8 +4078,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (page_mapcount(page) > 1 && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
-	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
+	/*
+	 * In memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    !node_is_toptier(page_nid))
+		last_cpupid = (-1 & LAST_CPUPID_MASK);
+	else
+		last_cpupid = page_cpupid_last(page);
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 9c5aa588ea4f..20774c88a307 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -641,6 +641,18 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	 * future migrations of this same page.
 	 */
 	cpupid = page_cpupid_xchg_last(page, -1);
+	/*
+	 * If migrate between slow and fast memory node, reset cpupid,
+	 * because that is used to record page access time in slow
+	 * memory node
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
+		bool f_toptier = node_is_toptier(page_to_nid(page));
+		bool t_toptier = node_is_toptier(page_to_nid(newpage));
+
+		if (f_toptier != t_toptier)
+			cpupid = -1;
+	}
 	page_cpupid_xchg_last(newpage, cpupid);
 
 	ksm_migrate_page(newpage, page);
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 4686fdc23bb9..aa94ec7176ed 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -112,4 +112,21 @@ int page_cpupid_xchg_last(struct page *page, int cpupid)
 
 	return last_cpupid;
 }
+
+unsigned int xchg_page_access_time(struct page *page, unsigned int time)
+{
+	unsigned long old_flags, flags;
+	unsigned int last_time;
+
+	time >>= PAGE_ACCESS_TIME_BUCKETS;
+	do {
+		old_flags = flags = page->flags;
+		last_time = (flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
+
+		flags &= ~(LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
+		flags |= (time & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
+	} while (unlikely(cmpxchg(&page->flags, old_flags, flags) != old_flags));
+
+	return last_time << PAGE_ACCESS_TIME_BUCKETS;
+}
 #endif
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8abec0c267fa..7c617bed45ee 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -85,6 +85,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (prot_numa) {
 				struct page *page;
 				int nid;
+				bool toptier;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -114,14 +115,19 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				nid = page_to_nid(page);
 				if (target_node == nid)
 					continue;
+				toptier = node_is_toptier(nid);
 
 				/*
 				 * Skip scanning top tier node if normal numa
 				 * balancing is disabled
 				 */
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-				    node_is_toptier(nid))
+				    toptier)
 					continue;
+				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+				    !toptier)
+					xchg_page_access_time(page,
+						jiffies_to_msecs(jiffies));
 			}
 
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
-- 
2.27.0

