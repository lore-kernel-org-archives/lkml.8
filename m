Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACD920760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCzQ3CZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgF3AoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgF3AoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:44:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEECC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 17:44:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id k7so8160470pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 17:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0aKSg4enppw3omuJsgtHx/x0BaQCXGbr10nLU30c2nM=;
        b=GCzQ3CZw8ycKukijr4zhfY+6CQEHGJLBhAHyCWFBPXLE9bnms1tCMPLeqaw6PrLXlE
         +0TJ215AiVdAQwZ8BFlJpnc8kXzC1Yey7XRZ2hjiOFBC6KizBQl7sMINwLzACCzpVKej
         /5tRbO19HGO7M+G1mY+QI70BKIkuiGJ0aQHONRR1eTiP/+99BvuwsDa2D8UC81ZiK2i2
         zcnWWknB09h6r1T9rXlU+TpAsP0lDbTvipQ7d7xucyPFF3dLXxvIubeE4BG4PlCfg/dz
         be4Wh2RYXz12rdxW0oXmjxU4SKEKUlOl/uxz3STIkfiLPX2fu7+Akk07zQhJq4YeDqKF
         MsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0aKSg4enppw3omuJsgtHx/x0BaQCXGbr10nLU30c2nM=;
        b=tzuse/3yBME+3SCpF4IVuZ6iQM4EUSuHyhi1hvQNFXshP41onbS4zGFhF2zwcSC+RM
         GCyfTnGZcGduQQ893m1FdqCwzJ8L4oaKEYgugev9Z6tEOjgvYj8A0/xfyyRpYPbx9pw7
         aNjM77Yj75NQQboqANQrtEdj/lccsVbbNv79hzp3ibz2CmHOHgw2JgUGFwyos2TsD94o
         cKU2ECxN4pzAxgGrXkR00EThNSt8O2e6xRuIp/9Qc2hGv8/O8kxSQdciza/3RWR7apQy
         3oTbulcooL4kL0jjFc/GZmFuCKsbVvg4VnJe3N8yPN9atGNyiqIwwRFbUD9cZCBW0F8E
         oh/g==
X-Gm-Message-State: AOAM5327L74YmL6PGbAaK5frRpfI0/XVnSOV/Fwax8U3WDDgGi+EYXEB
        DtwF/6daT6kjNXBwhdFrdh5k60SpiJxUzQ==
X-Google-Smtp-Source: ABdhPJwR392dp05vt9q5riFi+yk62Bo2Xp3HnK2dHLZXb07dH5n/F2zNwT4qqjPPABu82UpmZQURnOyy2BEcTQ==
X-Received: by 2002:a17:90a:a115:: with SMTP id s21mr14264564pjp.232.1593477863146;
 Mon, 29 Jun 2020 17:44:23 -0700 (PDT)
Date:   Mon, 29 Jun 2020 17:44:13 -0700
Message-Id: <20200630004413.1423733-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] mm: memcontrol: account kernel stack per node
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel stack is being accounted per-zone. There is no need
to do that. In addition due to being per-zone, memcg has to keep a
separate MEMCG_KERNEL_STACK_KB. Make the stat per-node and deprecate
MEMCG_KERNEL_STACK_KB as memcg_stat_item is an extension of
node_stat_item.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 drivers/base/node.c        |  4 ++--
 fs/proc/meminfo.c          |  4 ++--
 include/linux/memcontrol.h |  2 --
 include/linux/mmzone.h     |  8 ++++----
 kernel/fork.c              | 29 ++++++++++-------------------
 kernel/scs.c               |  2 +-
 mm/memcontrol.c            |  2 +-
 mm/page_alloc.c            | 16 ++++++++--------
 mm/vmstat.c                |  8 ++++----
 9 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0cf13e31603c..508b80f6329b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -440,9 +440,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 		       nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 		       nid, K(i.sharedram),
-		       nid, sum_zone_node_page_state(nid, NR_KERNEL_STACK_KB),
+		       nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
-		       nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_KB),
+		       nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
 		       nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
 		       nid, 0UL,
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index f262bff3ca31..887a5532e449 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -101,10 +101,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_zone_page_state(NR_KERNEL_STACK_KB));
+		   global_node_page_state(NR_KERNEL_STACK_KB));
 #ifdef CONFIG_SHADOW_CALL_STACK
 	seq_printf(m, "ShadowCallStack:%8lu kB\n",
-		   global_zone_page_state(NR_KERNEL_SCS_KB));
+		   global_node_page_state(NR_KERNEL_SCS_KB));
 #endif
 	show_val_kb(m, "PageTables:     ",
 		    global_zone_page_state(NR_PAGETABLE));
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ba1e42715ecf..a3ddb236898e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -33,8 +33,6 @@ enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
-	/* XXX: why are these zone and not node counters? */
-	MEMCG_KERNEL_STACK_KB,
 	MEMCG_NR_STAT,
 };
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8e859444927a..b79f73ce8b57 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -153,10 +153,6 @@ enum zone_stat_item {
 	NR_ZONE_WRITE_PENDING,	/* Count of dirty, writeback and unstable pages */
 	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
 	NR_PAGETABLE,		/* used for pagetables */
-	NR_KERNEL_STACK_KB,	/* measured in KiB */
-#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
-	NR_KERNEL_SCS_KB,	/* measured in KiB */
-#endif
 	/* Second 128 byte cacheline */
 	NR_BOUNCE,
 #if IS_ENABLED(CONFIG_ZSMALLOC)
@@ -201,6 +197,10 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
+	NR_KERNEL_STACK_KB,	/* measured in KiB */
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+	NR_KERNEL_SCS_KB,	/* measured in KiB */
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 73fdfa9674b5..ee5393350ef7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -278,7 +278,7 @@ static inline void free_thread_stack(struct task_struct *tsk)
 
 		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
 			mod_memcg_page_state(vm->pages[i],
-					     MEMCG_KERNEL_STACK_KB,
+					     NR_KERNEL_STACK_KB,
 					     -(int)(PAGE_SIZE / 1024));
 
 			memcg_kmem_uncharge_page(vm->pages[i], 0);
@@ -381,32 +381,23 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	void *stack = task_stack_page(tsk);
 	struct vm_struct *vm = task_stack_vm_area(tsk);
+	struct page *page;
 
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
 
 	if (vm) {
-		int i;
-
 		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
+		page = vm->pages[0];
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			mod_zone_page_state(page_zone(vm->pages[i]),
-					    NR_KERNEL_STACK_KB,
-					    PAGE_SIZE / 1024 * account);
-		}
 	} else {
-		/*
-		 * All stack pages are in the same zone and belong to the
-		 * same memcg.
-		 */
-		struct page *first_page = virt_to_page(stack);
-
-		mod_zone_page_state(page_zone(first_page), NR_KERNEL_STACK_KB,
-				    THREAD_SIZE / 1024 * account);
-
-		mod_memcg_obj_state(stack, MEMCG_KERNEL_STACK_KB,
+		page = virt_to_page(stack);
+		mod_memcg_obj_state(stack, NR_KERNEL_STACK_KB,
 				    account * (THREAD_SIZE / 1024));
 	}
+
+	/* All stack pages are in the same node. */
+	mod_node_page_state(page_pgdat(page), NR_KERNEL_STACK_KB,
+			    THREAD_SIZE / 1024 * account);
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
@@ -431,7 +422,7 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
 				return ret;
 
 			mod_memcg_page_state(vm->pages[i],
-					     MEMCG_KERNEL_STACK_KB,
+					     NR_KERNEL_STACK_KB,
 					     PAGE_SIZE / 1024);
 		}
 	}
diff --git a/kernel/scs.c b/kernel/scs.c
index 5d4d9bbdec36..4ff4a7ba0094 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -17,7 +17,7 @@ static void __scs_account(void *s, int account)
 {
 	struct page *scs_page = virt_to_page(s);
 
-	mod_zone_page_state(page_zone(scs_page), NR_KERNEL_SCS_KB,
+	mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_KB,
 			    account * (SCS_SIZE / SZ_1K));
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b1a644224383..06de63901f81 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1485,7 +1485,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
 		       PAGE_SIZE);
 	seq_buf_printf(&s, "kernel_stack %llu\n",
-		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
+		       (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
 		       1024);
 	seq_buf_printf(&s, "slab %llu\n",
 		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 174c849ba9f2..0568b126f719 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5402,6 +5402,10 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" anon_thp: %lukB"
 #endif
 			" writeback_tmp:%lukB"
+			" kernel_stack:%lukB"
+#ifdef CONFIG_SHADOW_CALL_STACK
+			" shadow_call_stack:%lukB"
+#endif
 			" all_unreclaimable? %s"
 			"\n",
 			pgdat->node_id,
@@ -5423,6 +5427,10 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+			node_page_state(pgdat, NR_KERNEL_STACK_KB),
+#ifdef CONFIG_SHADOW_CALL_STACK
+			node_page_state(pgdat, NR_KERNEL_SCS_KB),
+#endif
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
 	}
@@ -5454,10 +5462,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" present:%lukB"
 			" managed:%lukB"
 			" mlocked:%lukB"
-			" kernel_stack:%lukB"
-#ifdef CONFIG_SHADOW_CALL_STACK
-			" shadow_call_stack:%lukB"
-#endif
 			" pagetables:%lukB"
 			" bounce:%lukB"
 			" free_pcp:%lukB"
@@ -5479,10 +5483,6 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone->present_pages),
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
-			zone_page_state(zone, NR_KERNEL_STACK_KB),
-#ifdef CONFIG_SHADOW_CALL_STACK
-			zone_page_state(zone, NR_KERNEL_SCS_KB),
-#endif
 			K(zone_page_state(zone, NR_PAGETABLE)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 2c5a96694490..96bf8bfffd1d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1158,10 +1158,6 @@ const char * const vmstat_text[] = {
 	"nr_zone_write_pending",
 	"nr_mlock",
 	"nr_page_table_pages",
-	"nr_kernel_stack",
-#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
-	"nr_shadow_call_stack",
-#endif
 	"nr_bounce",
 #if IS_ENABLED(CONFIG_ZSMALLOC)
 	"nr_zspages",
@@ -1212,6 +1208,10 @@ const char * const vmstat_text[] = {
 	"nr_kernel_misc_reclaimable",
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
+	"nr_kernel_stack",
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+	"nr_shadow_call_stack",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.27.0.212.ge8ba1cc988-goog

