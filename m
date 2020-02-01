Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC3C33CB2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 03:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC324206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 03:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBADPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 22:15:18 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56990 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgBADPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 22:15:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tos5PLC_1580526907;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tos5PLC_1580526907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 01 Feb 2020 11:15:13 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: Detach node lock from counting free objects
Date:   Sat,  1 Feb 2020 11:15:02 +0800
Message-Id: <20200201031502.92218-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock, protecting the node partial list, is taken when couting the free
objects resident in that list. It introduces locking contention when the
page(s) is moved between CPU and node partial lists in allocation path
on another CPU. So reading "/proc/slabinfo" can possibily block the slab
allocation on another CPU for a while, 200ms in extreme cases. If the
slab object is to carry network packet, targeting the far-end disk array,
it causes block IO jitter issue.

This fixes the block IO jitter issue by caching the total inuse objects in
the node in advance. The value is retrieved without taking the node partial
list lock on reading "/proc/slabinfo".

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/slab.h |  1 +
 mm/slub.c | 42 +++++++++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7e94700aa78c..27d22837f7ff 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -619,6 +619,7 @@ struct kmem_cache_node {
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
+	atomic_long_t total_inuse;
 	struct list_head full;
 #endif
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 503e11b1c4e1..67640e797550 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1060,7 +1060,8 @@ static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
 	return atomic_long_read(&n->nr_slabs);
 }
 
-static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
+static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects,
+				  int inuse)
 {
 	struct kmem_cache_node *n = get_node(s, node);
 
@@ -1073,14 +1074,17 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
 	if (likely(n)) {
 		atomic_long_inc(&n->nr_slabs);
 		atomic_long_add(objects, &n->total_objects);
+		atomic_long_add(inuse, &n->total_inuse);
 	}
 }
-static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
+static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects,
+				  int inuse)
 {
 	struct kmem_cache_node *n = get_node(s, node);
 
 	atomic_long_dec(&n->nr_slabs);
 	atomic_long_sub(objects, &n->total_objects);
+	atomic_long_sub(inuse, &n->total_inuse);
 }
 
 /* Object debug checks for alloc/free paths */
@@ -1395,9 +1399,11 @@ static inline unsigned long slabs_node(struct kmem_cache *s, int node)
 static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
 							{ return 0; }
 static inline void inc_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
+							int objects,
+							int inuse) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
+							int objects,
+							int inuse) {}
 
 #endif /* CONFIG_SLUB_DEBUG */
 
@@ -1708,7 +1714,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (!page)
 		return NULL;
 
-	inc_slabs_node(s, page_to_nid(page), page->objects);
+	inc_slabs_node(s, page_to_nid(page), page->objects, page->inuse);
 
 	return page;
 }
@@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
 
 static void discard_slab(struct kmem_cache *s, struct page *page)
 {
-	dec_slabs_node(s, page_to_nid(page), page->objects);
+	int inuse = page->objects;
+
+	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
 	free_slab(s, page);
 }
 
@@ -2396,9 +2404,9 @@ static inline int node_match(struct page *page, int node)
 }
 
 #ifdef CONFIG_SLUB_DEBUG
-static int count_free(struct page *page)
+static inline unsigned long node_nr_inuse(struct kmem_cache_node *n)
 {
-	return page->objects - page->inuse;
+	return atomic_long_read(&n->total_inuse);
 }
 
 static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
@@ -2448,14 +2456,14 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 	for_each_kmem_cache_node(s, node, n) {
 		unsigned long nr_slabs;
 		unsigned long nr_objs;
-		unsigned long nr_free;
+		unsigned long nr_inuse;
 
-		nr_free  = count_partial(n, count_free);
 		nr_slabs = node_nr_slabs(n);
 		nr_objs  = node_nr_objs(n);
+		nr_inuse = node_nr_inuse(n);
 
 		pr_warn("  node %d: slabs: %ld, objs: %ld, free: %ld\n",
-			node, nr_slabs, nr_objs, nr_free);
+			node, nr_slabs, nr_objs, nr_objs - nr_inuse);
 	}
 #endif
 }
@@ -3348,6 +3356,7 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_set(&n->nr_slabs, 0);
 	atomic_long_set(&n->total_objects, 0);
+	atomic_long_set(&n->total_inuse, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
 }
@@ -3411,7 +3420,7 @@ static void early_kmem_cache_node_alloc(int node)
 	page->frozen = 0;
 	kmem_cache_node->node[node] = n;
 	init_kmem_cache_node(n);
-	inc_slabs_node(kmem_cache_node, node, page->objects);
+	inc_slabs_node(kmem_cache_node, node, page->objects, page->inuse);
 
 	/*
 	 * No locks need to be taken here as it has just been
@@ -4857,8 +4866,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 			if (flags & SO_TOTAL)
 				x = atomic_long_read(&n->total_objects);
 			else if (flags & SO_OBJECTS)
-				x = atomic_long_read(&n->total_objects) -
-					count_partial(n, count_free);
+				x = atomic_long_read(&n->total_inuse);
 			else
 				x = atomic_long_read(&n->nr_slabs);
 			total += x;
@@ -5900,17 +5908,17 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 {
 	unsigned long nr_slabs = 0;
 	unsigned long nr_objs = 0;
-	unsigned long nr_free = 0;
+	unsigned long nr_inuse = 0;
 	int node;
 	struct kmem_cache_node *n;
 
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
-		nr_free += count_partial(n, count_free);
+		nr_inuse += node_nr_inuse(n);
 	}
 
-	sinfo->active_objs = nr_objs - nr_free;
+	sinfo->active_objs = nr_inuse;
 	sinfo->num_objs = nr_objs;
 	sinfo->active_slabs = nr_slabs;
 	sinfo->num_slabs = nr_slabs;
-- 
2.23.0

