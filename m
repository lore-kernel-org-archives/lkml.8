Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC8C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBF220870
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGJOCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:02:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:10795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJOCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:02:20 -0400
IronPort-SDR: GzAHSXQpWeVTu5KOnkyPzld+CXInNq85q2y/VemT6FGe8IVSWrAE7VyJUmvbMsvSTubWgK8LsQ
 LIjBcJjFMubw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146267652"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="146267652"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 07:02:08 -0700
IronPort-SDR: GHH9ax0KhWzrg0MR0pQWTtFCjBFJr49qObvLj/i1znSakK6C9EfRnc99IZfHwI8oQFA+DVTf4C
 iPGLKauHK3Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="458287227"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2020 07:02:05 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        Dennis Zhou <dennis@kernel.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v6 4/4] mm: adjust vm_committed_as_batch according to vm overcommit policy
Date:   Fri, 10 Jul 2020 22:01:48 +0800
Message-Id: <1594389708-60781-5-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
References: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a performance change for will-it-scale scalability mmap test
[1], we found very high lock contention for spinlock of percpu counter
'vm_committed_as':

    94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
    48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
    45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;

Actually this heavy lock contention is not always necessary.  The
'vm_committed_as' needs to be very precise when the strict
OVERCOMMIT_NEVER policy is set, which requires a rather small batch number
for the percpu counter.

So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy, and
lift it to 64X for OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS policies.  Also
add a sysctl handler to adjust it when the policy is reconfigured.

Benchmark with the same testcase in [1] shows 53% improvement on a 8C/16T
desktop, and 2097%(20X) on a 4S/72C/144T server.  We tested with test
platforms in 0day (server, desktop and laptop), and 80%+ platforms shows
improvements with that test.  And whether it shows improvements depends on
if the test mmap size is bigger than the batch number computed.

And if the lift is 16X, 1/3 of the platforms will show improvements,
though it should help the mmap/unmap usage generally, as Michal Hocko
mentioned:

: I believe that there are non-synthetic worklaods which would benefit from
: a larger batch.  E.g.  large in memory databases which do large mmaps
: during startups from multiple threads.

[1] https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/

Link: http://lkml.kernel.org/r/1589611660-89854-4-git-send-email-feng.tang@intel.com
Link: http://lkml.kernel.org/r/1592725000-73486-4-git-send-email-feng.tang@intel.com
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Qian Cai <cai@lca.pw>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
---
 include/linux/mm.h   |  2 ++
 include/linux/mman.h |  4 ++++
 kernel/sysctl.c      |  2 +-
 mm/mm_init.c         | 22 ++++++++++++++++------
 mm/util.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e529e90..678ea25 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -208,6 +208,8 @@ int overcommit_ratio_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
+int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
+		loff_t *);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 6733f2f..629cefc 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -57,8 +57,12 @@ extern struct percpu_counter vm_committed_as;
 
 #ifdef CONFIG_SMP
 extern s32 vm_committed_as_batch;
+extern void mm_compute_batch(int overcommit_policy);
 #else
 #define vm_committed_as_batch 0
+static inline void mm_compute_batch(int overcommit_policy)
+{
+}
 #endif
 
 unsigned long vm_memory_committed(void);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8dca889..51ad1aa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2664,7 +2664,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_overcommit_memory,
 		.maxlen		= sizeof(sysctl_overcommit_memory),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= overcommit_policy_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 435e5f7..b06a30f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -13,6 +13,7 @@
 #include <linux/memory.h>
 #include <linux/notifier.h>
 #include <linux/sched.h>
+#include <linux/mman.h>
 #include "internal.h"
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
@@ -144,14 +145,23 @@ EXPORT_SYMBOL_GPL(mm_kobj);
 #ifdef CONFIG_SMP
 s32 vm_committed_as_batch = 32;
 
-static void __meminit mm_compute_batch(void)
+void mm_compute_batch(int overcommit_policy)
 {
 	u64 memsized_batch;
 	s32 nr = num_present_cpus();
 	s32 batch = max_t(s32, nr*2, 32);
-
-	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
-	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
+	unsigned long ram_pages = totalram_pages();
+
+	/*
+	 * For policy OVERCOMMIT_NEVER, set batch size to 0.4% of
+	 * (total memory/#cpus), and lift it to 25% for other policies
+	 * to easy the possible lock contention for percpu_counter
+	 * vm_committed_as, while the max limit is INT_MAX
+	 */
+	if (overcommit_policy == OVERCOMMIT_NEVER)
+		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
+	else
+		memsized_batch = min_t(u64, ram_pages/nr/4, INT_MAX);
 
 	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
 }
@@ -162,7 +172,7 @@ static int __meminit mm_compute_batch_notifier(struct notifier_block *self,
 	switch (action) {
 	case MEM_ONLINE:
 	case MEM_OFFLINE:
-		mm_compute_batch();
+		mm_compute_batch(sysctl_overcommit_memory);
 	default:
 		break;
 	}
@@ -176,7 +186,7 @@ static struct notifier_block compute_batch_nb __meminitdata = {
 
 static int __init mm_compute_batch_init(void)
 {
-	mm_compute_batch();
+	mm_compute_batch(sysctl_overcommit_memory);
 	register_hotmemory_notifier(&compute_batch_nb);
 
 	return 0;
diff --git a/mm/util.c b/mm/util.c
index d076218..79c965d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -746,6 +746,47 @@ int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
+static void sync_overcommit_as(struct work_struct *dummy)
+{
+	percpu_counter_sync(&vm_committed_as);
+}
+
+int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int new_policy;
+	int ret;
+
+	/*
+	 * The deviation of sync_overcommit_as could be big with loose policy
+	 * like OVERCOMMIT_ALWAYS/OVERCOMMIT_GUESS. When changing policy to
+	 * strict OVERCOMMIT_NEVER, we need to reduce the deviation to comply
+	 * with the strict "NEVER", and to avoid possible race condtion (even
+	 * though user usually won't too frequently do the switching to policy
+	 * OVERCOMMIT_NEVER), the switch is done in the following order:
+	 *	1. changing the batch
+	 *	2. sync percpu count on each CPU
+	 *	3. switch the policy
+	 */
+	if (write) {
+		t = *table;
+		t.data = &new_policy;
+		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+		if (ret)
+			return ret;
+
+		mm_compute_batch(new_policy);
+		if (new_policy == OVERCOMMIT_NEVER)
+			schedule_on_each_cpu(sync_overcommit_as);
+		sysctl_overcommit_memory = new_policy;
+	} else {
+		ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	}
+
+	return ret;
+}
+
 int overcommit_kbytes_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-- 
2.7.4

