Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F09C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15F320736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEHHZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:25:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:27650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHHZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:25:34 -0400
IronPort-SDR: sYDcVRsecww0kbq/YIDC5SUM0URsdSMOz80yh4xLW+ehkflMXD1PKpwz3O3SPBs29aY5woWx5I
 jypBB1TbzvTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 00:25:34 -0700
IronPort-SDR: /EANI/ZJmWkl7bx+3saQMpoxOdCPopKbVG3WLhHGTLeN3GmCsrNXocVaE8sZZUBI/7nST1nL0S
 mLkl5NLQugfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="264210569"
Received: from shbuild999.sh.intel.com ([10.239.147.136])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 00:25:30 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm overcommit policy
Date:   Fri,  8 May 2020 15:25:17 +0800
Message-Id: <1588922717-63697-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
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

So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
when the policy is reconfigured.

Benchmark with the same testcase in [1] shows 53% improvement on a
8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
for some platforms, due to the test mmap size of the case is bigger
than the batch number computed, though the patch will help mmap/munmap
generally.

[1] https://lkml.org/lkml/2020/3/5/57

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mm.h   |  2 ++
 include/linux/mman.h |  4 ++++
 kernel/sysctl.c      |  2 +-
 mm/mm_init.c         | 19 +++++++++++++++----
 mm/util.c            | 13 +++++++++++++
 5 files changed, 35 insertions(+), 5 deletions(-)

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
index 7da6991..1654358 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -13,6 +13,7 @@
 #include <linux/memory.h>
 #include <linux/notifier.h>
 #include <linux/sched.h>
+#include <linux/mman.h>
 #include "internal.h"
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
@@ -140,16 +141,26 @@ EXPORT_SYMBOL_GPL(mm_kobj);
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
+	 * of (total memory/#cpus), and lift it to 6.25% for other
+	 * policies to easy the possible lock contention for percpu_counter
+	 * vm_committed_as, while the max limit is INT_MAX
+	 */
+	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
+		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
+	else
+		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);
 
 	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
+	printk("vm_committed_as_batch = %d\n", vm_committed_as_batch);
 }
 
 static int __meminit mm_compute_batch_notifier(struct notifier_block *self,
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

