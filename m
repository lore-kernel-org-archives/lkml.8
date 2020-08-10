Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916ECC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710F82070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHJMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:17:57 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56965 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbgHJMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:17:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U5MlrY9_1597061872;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U5MlrY9_1597061872)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 20:17:53 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH v2 1/3] mm/slub: Introduce two counters for partial objects
Date:   Mon, 10 Aug 2020 20:17:50 +0800
Message-Id: <1597061872-58724-2-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node list_lock in count_partial() spends long time iterating
in case of large amount of partial page lists, which can cause
thunder herd effect to the list_lock contention.

We have HSF RT(High-speed Service Framework Response-Time) monitors,
the RT figures fluctuated randomly, then we deployed a tool detecting
"irq off" and "preempt off" to dump the culprit's calltrace, capturing
the list_lock cost nearly 100ms with irq off issued by "ss", this also
caused network timeouts.

This patch introduces two counters to maintain the actual number
of partial objects dynamically instead of iterating the partial
page lists with list_lock held.

New counters of kmem_cache_node: partial_free_objs, partial_total_objs.
The main operations are under list_lock in slow path, its performance
impact should be minimal except the __slab_free() path which will be
addressed later.

Acked-by: Pekka Enberg <penberg@kernel.org>
Co-developed-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slab.h |  2 ++
 mm/slub.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7e94700..c85e2fa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -616,6 +616,8 @@ struct kmem_cache_node {
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
 	struct list_head partial;
+	atomic_long_t partial_free_objs;
+	atomic_long_t partial_total_objs;
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
diff --git a/mm/slub.c b/mm/slub.c
index 6589b41..6708d96 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1775,10 +1775,24 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
 /*
  * Management of partially allocated slabs.
  */
+
+static inline void
+__update_partial_free(struct kmem_cache_node *n, long delta)
+{
+	atomic_long_add(delta, &n->partial_free_objs);
+}
+
+static inline void
+__update_partial_total(struct kmem_cache_node *n, long delta)
+{
+	atomic_long_add(delta, &n->partial_total_objs);
+}
+
 static inline void
 __add_partial(struct kmem_cache_node *n, struct page *page, int tail)
 {
 	n->nr_partial++;
+	__update_partial_total(n, page->objects);
 	if (tail == DEACTIVATE_TO_TAIL)
 		list_add_tail(&page->slab_list, &n->partial);
 	else
@@ -1798,6 +1812,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
 	lockdep_assert_held(&n->list_lock);
 	list_del(&page->slab_list);
 	n->nr_partial--;
+	__update_partial_total(n, -page->objects);
 }
 
 /*
@@ -1842,6 +1857,7 @@ static inline void *acquire_slab(struct kmem_cache *s,
 		return NULL;
 
 	remove_partial(n, page);
+	__update_partial_free(n, -*objects);
 	WARN_ON(!freelist);
 	return freelist;
 }
@@ -2174,8 +2190,11 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 				"unfreezing slab"))
 		goto redo;
 
-	if (lock)
+	if (lock) {
+		if (m == M_PARTIAL)
+			__update_partial_free(n, page->objects - page->inuse);
 		spin_unlock(&n->list_lock);
+	}
 
 	if (m == M_PARTIAL)
 		stat(s, tail);
@@ -2241,6 +2260,7 @@ static void unfreeze_partials(struct kmem_cache *s,
 			discard_page = page;
 		} else {
 			add_partial(n, page, DEACTIVATE_TO_TAIL);
+			__update_partial_free(n, page->objects - page->inuse);
 			stat(s, FREE_ADD_PARTIAL);
 		}
 	}
@@ -2915,6 +2935,13 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		head, new.counters,
 		"__slab_free"));
 
+	if (!was_frozen && prior) {
+		if (n)
+			__update_partial_free(n, cnt);
+		else
+			__update_partial_free(get_node(s, page_to_nid(page)), cnt);
+	}
+
 	if (likely(!n)) {
 
 		/*
@@ -2944,6 +2971,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
 		remove_full(s, n, page);
 		add_partial(n, page, DEACTIVATE_TO_TAIL);
+		__update_partial_free(n, page->objects - page->inuse);
 		stat(s, FREE_ADD_PARTIAL);
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
@@ -2955,6 +2983,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		 * Slab on the partial list.
 		 */
 		remove_partial(n, page);
+		__update_partial_free(n, page->inuse - page->objects);
 		stat(s, FREE_REMOVE_PARTIAL);
 	} else {
 		/* Slab must be on the full list */
@@ -3364,6 +3393,8 @@ static inline int calculate_order(unsigned int size)
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
 	INIT_LIST_HEAD(&n->partial);
+	atomic_long_set(&n->partial_free_objs, 0);
+	atomic_long_set(&n->partial_total_objs, 0);
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_set(&n->nr_slabs, 0);
 	atomic_long_set(&n->total_objects, 0);
@@ -3437,6 +3468,7 @@ static void early_kmem_cache_node_alloc(int node)
 	 * initialized and there is no concurrent access.
 	 */
 	__add_partial(n, page, DEACTIVATE_TO_HEAD);
+	__update_partial_free(n, page->objects - page->inuse);
 }
 
 static void free_kmem_cache_nodes(struct kmem_cache *s)
@@ -3747,6 +3779,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	list_for_each_entry_safe(page, h, &n->partial, slab_list) {
 		if (!page->inuse) {
 			remove_partial(n, page);
+			__update_partial_free(n, page->objects - page->inuse);
 			list_add(&page->slab_list, &discard);
 		} else {
 			list_slab_objects(s, page,
@@ -4045,6 +4078,8 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 			if (free == page->objects) {
 				list_move(&page->slab_list, &discard);
 				n->nr_partial--;
+				__update_partial_free(n, -free);
+				__update_partial_total(n, -free);
 			} else if (free <= SHRINK_PROMOTE_MAX)
 				list_move(&page->slab_list, promote + free - 1);
 		}
-- 
1.8.3.1

