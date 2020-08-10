Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05063C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB02920709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHJMSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:18:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51252 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgHJMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:18:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U5N4-L-_1597061873;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U5N4-L-_1597061873)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 20:17:54 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
Date:   Mon, 10 Aug 2020 20:17:52 +0800
Message-Id: <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only concern of introducing partial counter is that,
partial_free_objs may cause atomic operation contention
in case of same SLUB concurrent __slab_free().

This patch changes it to be a percpu counter to avoid that.

Co-developed-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slab.h |  2 +-
 mm/slub.c | 38 +++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index c85e2fa..a709a70 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -616,7 +616,7 @@ struct kmem_cache_node {
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
 	struct list_head partial;
-	atomic_long_t partial_free_objs;
+	atomic_long_t __percpu *partial_free_objs;
 	atomic_long_t partial_total_objs;
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
diff --git a/mm/slub.c b/mm/slub.c
index 25a4421..f6fc60b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1775,11 +1775,21 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
 /*
  * Management of partially allocated slabs.
  */
+static inline long get_partial_free(struct kmem_cache_node *n)
+{
+	long nr = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		nr += atomic_long_read(per_cpu_ptr(n->partial_free_objs, cpu));
+
+	return nr;
+}
 
 static inline void
 __update_partial_free(struct kmem_cache_node *n, long delta)
 {
-	atomic_long_add(delta, &n->partial_free_objs);
+	atomic_long_add(delta, this_cpu_ptr(n->partial_free_objs));
 }
 
 static inline void
@@ -2429,12 +2439,12 @@ static unsigned long partial_counter(struct kmem_cache_node *n,
 	unsigned long ret = 0;
 
 	if (item == PARTIAL_FREE) {
-		ret = atomic_long_read(&n->partial_free_objs);
+		ret = get_partial_free(n);
 	} else if (item == PARTIAL_TOTAL) {
 		ret = atomic_long_read(&n->partial_total_objs);
 	} else if (item == PARTIAL_INUSE) {
 		ret = atomic_long_read(&n->partial_total_objs) -
-		atomic_long_read(&n->partial_free_objs);
+				get_partial_free(n);
 		if ((long)ret < 0)
 			ret = 0;
 	}
@@ -3390,19 +3400,28 @@ static inline int calculate_order(unsigned int size)
 	return -ENOSYS;
 }
 
-static void
+static int
 init_kmem_cache_node(struct kmem_cache_node *n)
 {
+	int cpu;
+
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
 	INIT_LIST_HEAD(&n->partial);
-	atomic_long_set(&n->partial_free_objs, 0);
+
+	n->partial_free_objs = alloc_percpu(atomic_long_t);
+	if (!n->partial_free_objs)
+		return -ENOMEM;
+	for_each_possible_cpu(cpu)
+		atomic_long_set(per_cpu_ptr(n->partial_free_objs, cpu), 0);
 	atomic_long_set(&n->partial_total_objs, 0);
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_set(&n->nr_slabs, 0);
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
+
+	return 0;
 }
 
 static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
@@ -3463,7 +3482,7 @@ static void early_kmem_cache_node_alloc(int node)
 	page->inuse = 1;
 	page->frozen = 0;
 	kmem_cache_node->node[node] = n;
-	init_kmem_cache_node(n);
+	BUG_ON(init_kmem_cache_node(n) < 0);
 	inc_slabs_node(kmem_cache_node, node, page->objects);
 
 	/*
@@ -3481,6 +3500,7 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 
 	for_each_kmem_cache_node(s, node, n) {
 		s->node[node] = NULL;
+		free_percpu(n->partial_free_objs);
 		kmem_cache_free(kmem_cache_node, n);
 	}
 }
@@ -3511,7 +3531,11 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 			return 0;
 		}
 
-		init_kmem_cache_node(n);
+		if (init_kmem_cache_node(n) < 0) {
+			free_kmem_cache_nodes(s);
+			return 0;
+		}
+
 		s->node[node] = n;
 	}
 	return 1;
-- 
1.8.3.1

