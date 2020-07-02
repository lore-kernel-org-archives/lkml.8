Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A45C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F7520720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGBIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:32:15 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35602 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgGBIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:32:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U1Tsvtm_1593678728;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U1Tsvtm_1593678728)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jul 2020 16:32:08 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/slub: Get rid of count_partial()
Date:   Thu,  2 Jul 2020 16:32:08 +0800
Message-Id: <1593678728-128358-2-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the partial counters are ready, let's use them directly
and get rid of count_partial().

Co-developed-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slub.c | 57 ++++++++++++++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 53890f3..f1946ed 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2414,11 +2414,6 @@ static inline int node_match(struct page *page, int node)
 }
 
 #ifdef CONFIG_SLUB_DEBUG
-static int count_free(struct page *page)
-{
-	return page->objects - page->inuse;
-}
-
 static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 {
 	return atomic_long_read(&n->total_objects);
@@ -2426,19 +2421,27 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
-static unsigned long count_partial(struct kmem_cache_node *n,
-					int (*get_count)(struct page *))
-{
-	unsigned long flags;
-	unsigned long x = 0;
-	struct page *page;
+enum partial_item { PARTIAL_FREE, PARTIAL_INUSE, PARTIAL_TOTAL };
+
+static unsigned long partial_counter(struct kmem_cache_node *n,
+		enum partial_item item)
+{
+	unsigned long ret = 0;
+
+	if (item == PARTIAL_FREE) {
+		ret = atomic_long_read(&n->pfree_objects);
+	} else if (item == PARTIAL_TOTAL) {
+		ret = atomic_long_read(&n->total_objects);
+	} else if (item == PARTIAL_INUSE) {
+		ret = atomic_long_read(&n->total_objects) -
+		atomic_long_read(&n->pfree_objects);
+		if ((long)ret < 0)
+			ret = 0;
+	}
 
-	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(page, &n->partial, slab_list)
-		x += get_count(page);
-	spin_unlock_irqrestore(&n->list_lock, flags);
-	return x;
+	return ret;
 }
+
 #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
 
 static noinline void
@@ -2468,7 +2471,7 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 		unsigned long nr_objs;
 		unsigned long nr_free;
 
-		nr_free  = count_partial(n, count_free);
+		nr_free  = partial_counter(n, PARTIAL_FREE);
 		nr_slabs = node_nr_slabs(n);
 		nr_objs  = node_nr_objs(n);
 
@@ -4445,18 +4448,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 }
 #endif
 
-#ifdef CONFIG_SYSFS
-static int count_inuse(struct page *page)
-{
-	return page->inuse;
-}
-
-static int count_total(struct page *page)
-{
-	return page->objects;
-}
-#endif
-
 #ifdef CONFIG_SLUB_DEBUG
 static void validate_slab(struct kmem_cache *s, struct page *page)
 {
@@ -4913,7 +4904,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 				x = atomic_long_read(&n->total_objects);
 			else if (flags & SO_OBJECTS)
 				x = atomic_long_read(&n->total_objects) -
-					count_partial(n, count_free);
+					partial_counter(n, PARTIAL_FREE);
 			else
 				x = atomic_long_read(&n->nr_slabs);
 			total += x;
@@ -4927,9 +4918,9 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 
 		for_each_kmem_cache_node(s, node, n) {
 			if (flags & SO_TOTAL)
-				x = count_partial(n, count_total);
+				x = partial_counter(n, PARTIAL_TOTAL);
 			else if (flags & SO_OBJECTS)
-				x = count_partial(n, count_inuse);
+				x = partial_counter(n, PARTIAL_INUSE);
 			else
 				x = n->nr_partial;
 			total += x;
@@ -5962,7 +5953,7 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
-		nr_free += count_partial(n, count_free);
+		nr_free += partial_counter(n, PARTIAL_FREE);
 	}
 
 	sinfo->active_objs = nr_objs - nr_free;
-- 
1.8.3.1

