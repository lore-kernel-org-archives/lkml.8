Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F370C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6220767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgEPGrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:47:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:41267 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgEPGry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:47:54 -0400
IronPort-SDR: Kp8ZPLQwOV9/3JV0q6faYRsQ81Ujy2tUtKpygt9pU53BOQacPyHplhd3QzDbr63meJq9nnnKNl
 zo6WDq6r+8wA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 23:47:54 -0700
IronPort-SDR: HHu9rIu2MAMCIdBVEDX2y+JFZyieAXcsspWNbHGNzFFnDtnSzMnYAptng4hHPYl7llMAARnoSm
 BYpgY62Uj5hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="464984951"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 23:47:51 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 3/3] mm: adjust vm_committed_as_batch according to vm overcommit policy
Date:   Sat, 16 May 2020 14:47:40 +0800
Message-Id: <1589611660-89854-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589611660-89854-1-git-send-email-feng.tang@intel.com>
References: <1589611660-89854-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a performance change for will-it-scale scalability
mmap test [1], we found very high lock contention for spinlock of
percpu counter 'vm_committed_as':

    94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
    48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
    45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;

Actually this heavy lock contention is not always necessary. The
'vm_committed_as' needs to be very precise when the strict
OVERCOMMIT_NEVER policy is set, which requires a rather small batch
number for the percpu counter.

So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy,
and lift it to 64X for OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS policies.
Also add a sysctl handler to adjust it when the policy is reconfigured.

Benchmark with the same testcase in [1] shows 53% improvement on a
8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. We tested
with test platforms in 0day (server, desktop and laptop), and 80%+
platforms shows improvements with that test. And whether it shows
improvements depends on if the test mmap size is bigger than the
batch number computed.

And if the lift is 16X, 1/3 of the platforms will show improvements,
though it should help the mmap/unmap usage generally, as Michal Hocko
mentioned:
"
I believe that there are non-synthetic worklaods which would benefit
from a larger batch. E.g. large in memory databases which do large
mmaps during startups from multiple threads.
"

[1] https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mm.h   |  2 ++
 include/linux/mman.h |  4 ++++
 kernel/sysctl.c      |  2 +-
 mm/mm_init.c         | 18 ++++++++++++++----
 mm/util.c            | 13 +++++++++++++
 5 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a32342..bc3722f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -205,6 +205,8 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
 extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
+extern int overcommit_policy_handler(struct ctl_table *, int, void __user *,
+				    size_t *, loff_t *);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 4b08e9c..91c93c1 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -57,8 +57,12 @@ extern struct percpu_counter vm_committed_as;
 
 #ifdef CONFIG_SMP
 extern s32 vm_committed_as_batch;
+extern void mm_compute_batch(void);
 #else
 #define vm_committed_as_batch 0
+static inline void mm_compute_batch(void)
+{
+}
 #endif
 
 unsigned long vm_memory_committed(void);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8..6fa552d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1278,7 +1278,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_overcommit_memory,
 		.maxlen		= sizeof(sysctl_overcommit_memory),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= overcommit_policy_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7da6991..b48dafd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -13,6 +13,7 @@
 #include <linux/memory.h>
 #include <linux/notifier.h>
 #include <linux/sched.h>
+#include <linux/mman.h>
 #include "internal.h"
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
@@ -140,14 +141,23 @@ EXPORT_SYMBOL_GPL(mm_kobj);
 #ifdef CONFIG_SMP
 s32 vm_committed_as_batch = 32;
 
-static void __meminit mm_compute_batch(void)
+void mm_compute_batch(void)
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
+	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
+	 * of (total memory/#cpus), and lift it to 25% for other
+	 * policies to easy the possible lock contention for percpu_counter
+	 * vm_committed_as, while the max limit is INT_MAX
+	 */
+	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
+		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
+	else
+		memsized_batch = min_t(u64, ram_pages/nr/4, INT_MAX);
 
 	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
 }
diff --git a/mm/util.c b/mm/util.c
index 3de78e9..99936d3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -729,6 +729,19 @@ int overcommit_ratio_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
+int overcommit_policy_handler(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp,
+			     loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret == 0 && write)
+		mm_compute_batch();
+
+	return ret;
+}
+
 int overcommit_kbytes_handler(struct ctl_table *table, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos)
-- 
2.7.4

