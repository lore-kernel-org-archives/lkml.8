Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F118C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6462D24683
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBRI1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:27:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:18962 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgBRI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="235466738"
Received: from yhuang-dev.sh.intel.com ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 00:27:38 -0800
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
Subject: [RFC -V2 8/8] autonuma, memory tiering: Adjust hot threshold automatically
Date:   Tue, 18 Feb 2020 16:26:34 +0800
Message-Id: <20200218082634.1596727-9-ying.huang@intel.com>
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

It isn't easy for the administrator to determine the hot threshold.
So in this patch, a method to adjust the hot threshold automatically
is implemented.  The basic idea is to control the number of the
candidate promotion pages to match the promotion rate limit.  If the
hint page fault latency of a page is less than the hot threshold, we
will try to promote the page, that is, the page is the candidate
promotion page.

If the number of the candidate promotion pages in the statistics
interval is much higher than the promotion rate limit, the hot
threshold will be lowered to reduce the number of the candidate
promotion pages.  Otherwise, the hot threshold will be raised to
increase the number of the candidate promotion pages.

To make the above method works, in each statistics interval, the total
number of the pages to check (on which the hint page faults occur) and
the hot/cold distribution need to be stable.  Because the page tables
are scanned linearly in autonuma, but the hot/cold distribution isn't
uniform along the address.  The statistics interval should be larger
than the autonuma scan period.  So in the patch, the max scan period
is used as statistics interval and it works well in our tests.

The sysctl knob kernel.numa_balancing_hot_threshold_ms becomes the
initial value and max value of the hot threshold.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
5.5% with 24.6% fewer NUMA page migrations on a 2 socket Intel server
with Optance DC Persistent Memory.  Because it improves the accuracy
of the hot page selection.

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
 include/linux/mmzone.h |  3 +++
 kernel/sched/fair.c    | 40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6e7a28becdc2..4ed82eb5c8b5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -792,6 +792,9 @@ typedef struct pglist_data {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long numa_ts;
 	unsigned long numa_try;
+	unsigned long numa_threshold_ts;
+	unsigned long numa_threshold_try;
+	unsigned long numa_threshold;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5f7f4139c82..90098c35d336 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1487,6 +1487,35 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 	return true;
 }
 
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned long ref_th)
+{
+	unsigned long now = jiffies, last_th_ts, th_period;
+	unsigned long unit_th, th;
+	unsigned long try, ref_try, tdiff;
+
+	th_period = msecs_to_jiffies(sysctl_numa_balancing_scan_period_max);
+	last_th_ts = pgdat->numa_threshold_ts;
+	if (now > last_th_ts + th_period &&
+	    cmpxchg(&pgdat->numa_threshold_ts, last_th_ts, now) == last_th_ts) {
+		ref_try = rate_limit *
+			sysctl_numa_balancing_scan_period_max / 1000;
+		try = node_page_state(pgdat, NUMA_TRY_MIGRATE);
+		tdiff = try - pgdat->numa_threshold_try;
+		unit_th = ref_th / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->numa_threshold ? : ref_th;
+		if (tdiff > ref_try * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (tdiff < ref_try * 9 / 10)
+			th = min(th + unit_th, ref_th);
+		pgdat->numa_threshold_try = try;
+		pgdat->numa_threshold = th;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu, unsigned long addr,
 				int flags)
@@ -1502,7 +1531,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    next_promotion_node(src_nid) != -1) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit, latency, th;
+		unsigned long rate_limit, latency, th, def_th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1512,15 +1541,18 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		if (!(flags & TNF_YOUNG))
 			return false;
 
-		th = msecs_to_jiffies(sysctl_numa_balancing_hot_threshold);
+		def_th = msecs_to_jiffies(sysctl_numa_balancing_hot_threshold);
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		numa_migration_adjust_threshold(pgdat, rate_limit, def_th);
+
+		th = pgdat->numa_threshold ? : def_th;
 		if (flags & TNF_WRITE)
 			th *= 2;
 		latency = numa_hint_fault_latency(p, addr);
 		if (latency > th)
 			return false;
 
-		rate_limit =
-			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
 						       hpage_nr_pages(page));
 	}
-- 
2.24.1

