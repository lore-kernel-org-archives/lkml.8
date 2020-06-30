Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEEBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E34520722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITmC78T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgF3QP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgF3QPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:15:55 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43742C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:15:55 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id 46so5709635uao.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bXv7tFHYuFoDT+bV9yObzbdNniN4ZQt6n71y+59QZgU=;
        b=ITmC78T/W1E6u3FrKZeizUPZ25JHGQG8WTsG4EzB8aFC9/+itpaAlqWtCRGYKc4uRb
         reNrinkUb2PfnyDrYpq8ADdHntuHaVrvEvbLJxJQLJnu0k/PPitwm2pwJsdt8jVnnMd9
         EMQGFPu2i9te63GdO27YfGLHluZ20EBLIn3akBwevSukfjrVv/I9MO9ipQoll/p7o+dt
         zyfb25BZbpN5K/AP7vqUb2qsaSneTRJ/IOI4UxsDtwURHzEvK3v+/B4bYz67UkrEEzqT
         RuISp9mFEPEixq3mkwmt5mae+/y2C7x7G6Ul+hX/jxkSc1clqVWKa7QCRZd7wcJ5AyH/
         rqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bXv7tFHYuFoDT+bV9yObzbdNniN4ZQt6n71y+59QZgU=;
        b=rQN2N1TaXbDU+6obainyvvoKnn5LQBrp3ekjgl5nPGqpHLsEzjFsZ2PlL9LXoTvVpk
         EWZR87gelNQTM/3dBP76utvfll6c7Bjl6mnqnglelZNgHlAD1+Qp2lNOqB0XiUeNtavh
         04M0hQxC7JzH4Mj21zVBvZ3Wi+cfwd6oEQDP77DCyAxzcnCGN28BJjYeQBhW1gj2mIPJ
         f1MTrXFiOrxNDU2HglI+o/0lstHKM3XJCJM6qIjnn74Fr5PTm2htEf3Rut3KBR1L++Wy
         w79p/e+f5DLKJf4lOEE2JgrYHIUQ/o1qXEABAI6x9LTQKYj+smGSvXC7G1OxhYIJT3CK
         pfTw==
X-Gm-Message-State: AOAM532QUItWoBSMG0DvNQNwenPIa/9oSWy+TuXQyEVuv3YWp8ncpWXF
        dPgk3S+Zz/cd8AgdsKTwtQ0RLpMVC2bN8A==
X-Google-Smtp-Source: ABdhPJym+92LjjR3i7eSz0LjVdy1XOkJS30Q00cKHTC98R1UZCy+i0xSaP9ams3etj+J1Bd0xR88nfTiR1butg==
X-Received: by 2002:a1f:298f:: with SMTP id p137mr14550657vkp.11.1593533754424;
 Tue, 30 Jun 2020 09:15:54 -0700 (PDT)
Date:   Tue, 30 Jun 2020 09:15:39 -0700
Message-Id: <20200630161539.1759185-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2] mm: memcontrol: account kernel stack per node
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
node_stat_item. In addition localize the kernel stack stats updates to
account_kernel_stack().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- Use lruvec based stat update functions based on Roman's suggestion.

 drivers/base/node.c        |  4 +--
 fs/proc/meminfo.c          |  4 +--
 include/linux/memcontrol.h | 21 ++++++++++++++--
 include/linux/mmzone.h     |  8 +++---
 kernel/fork.c              | 51 +++++++++++---------------------------
 kernel/scs.c               |  2 +-
 mm/memcontrol.c            |  2 +-
 mm/page_alloc.c            | 16 ++++++------
 mm/vmstat.c                |  8 +++---
 9 files changed, 55 insertions(+), 61 deletions(-)

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
index ba1e42715ecf..b8f52a3fed90 100644
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
 
@@ -737,8 +735,19 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
+
 void mod_memcg_obj_state(void *p, int idx, int val);
 
+static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
+					 int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_lruvec_slab_state(p, idx, val);
+	local_irq_restore(flags);
+}
+
 static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
 					  enum node_stat_item idx, int val)
 {
@@ -1159,6 +1168,14 @@ static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
 	__mod_node_page_state(page_pgdat(page), idx, val);
 }
 
+static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
+					 int val)
+{
+	struct page *page = virt_to_head_page(p);
+
+	mod_node_page_state(page_pgdat(page), idx, val);
+}
+
 static inline void mod_memcg_obj_state(void *p, int idx, int val)
 {
 }
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
index 73fdfa9674b5..f00c7a4913e1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -276,13 +276,8 @@ static inline void free_thread_stack(struct task_struct *tsk)
 	if (vm) {
 		int i;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			mod_memcg_page_state(vm->pages[i],
-					     MEMCG_KERNEL_STACK_KB,
-					     -(int)(PAGE_SIZE / 1024));
-
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
 			memcg_kmem_uncharge_page(vm->pages[i], 0);
-		}
 
 		for (i = 0; i < NR_CACHED_STACKS; i++) {
 			if (this_cpu_cmpxchg(cached_stacks[i],
@@ -382,31 +377,14 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	void *stack = task_stack_page(tsk);
 	struct vm_struct *vm = task_stack_vm_area(tsk);
 
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
-
-	if (vm) {
-		int i;
-
-		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			mod_zone_page_state(page_zone(vm->pages[i]),
-					    NR_KERNEL_STACK_KB,
-					    PAGE_SIZE / 1024 * account);
-		}
-	} else {
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
-				    account * (THREAD_SIZE / 1024));
-	}
+	/* All stack pages are in the same node. */
+	if (vm)
+		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
+				      account * (THREAD_SIZE / 1024));
+	else
+		mod_lruvec_slab_state(stack, NR_KERNEL_STACK_KB,
+				      account * (THREAD_SIZE / 1024));
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
@@ -415,24 +393,23 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
 	struct vm_struct *vm = task_stack_vm_area(tsk);
 	int ret;
 
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
+
 	if (vm) {
 		int i;
 
+		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
+
 		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
 			/*
 			 * If memcg_kmem_charge_page() fails, page->mem_cgroup
-			 * pointer is NULL, and both memcg_kmem_uncharge_page()
-			 * and mod_memcg_page_state() in free_thread_stack()
-			 * will ignore this page. So it's safe.
+			 * pointer is NULL, and memcg_kmem_uncharge_page() in
+			 * free_thread_stack() will ignore this page.
 			 */
 			ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
 						     0);
 			if (ret)
 				return ret;
-
-			mod_memcg_page_state(vm->pages[i],
-					     MEMCG_KERNEL_STACK_KB,
-					     PAGE_SIZE / 1024);
 		}
 	}
 #endif
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

