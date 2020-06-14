Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F07C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42ABE20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="x7gfvf+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgFNMjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:39:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3181C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so5582255pje.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l67osNkqzsUW+dZnlugsZ85KWtdqaVq9bkvvCdirhlY=;
        b=x7gfvf+24TATO2r4VlHMg25pPbiicqdLFSV97yRYsBjuL5hhZ6VsEiy7CrTMsQ1wQQ
         PBd4iWRe9i6yLhvg8wgKH4i0l331phWmXcoe+Rgy4DBu4sXaccj44z5AyvyOKiil+q8y
         r+mZTRjQPzm+BuHj3ydV8Ke9WA/EN9M157UgUvDDbfkxUnSGO8icyoyqRrYeAItc6Z73
         YeuOMVyFY7dr9q+64IMHla9ksEN5bJpsEuXoClHZN5LFJi3+cEIjzITRcjqyJsdMoH9C
         M8wMKDxqOs8OgMOVdN5DrnUUfXBrLeAu1PLl5LVU0BIdPOWVFP2DLxog1eldKJdcPQ5i
         lNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l67osNkqzsUW+dZnlugsZ85KWtdqaVq9bkvvCdirhlY=;
        b=CeiXj0QlzJplQJc8/APTdH8RA2iaTnkjSgP+lsRqd1xYutU7U2JXt2+RU1rCuCUt8K
         R2CGhPlUYkg/AnuAdb1TvK/LpTHtsl6PQDPpA1BIq4ugNaXwHFOuRbQ231WsI/xChv1U
         xKas8VxK5l4HdyvDkR/uEAV/XnOpupc/zLGVwztmwCG8kzsvrli81GCfj9NoanSxfAb/
         2mT3aXL5xUHKZ5VDuawugYNOlhwlc4zwppc7AnMx0+kG8pvPYhgT8PSNAuZ/jiuH+R3B
         Mi1DdtkRxeZJBa17lGeJHKRh25zuzSGhhvTeaAAjrM9voUhpu93HxOoDH6KphoilWn2l
         tKUA==
X-Gm-Message-State: AOAM533U2NlDWkht+rNxYK8ourAz3XFGHw6EnOr4IyyIRg8XqnMYN9MA
        zuMxnVLgsxf2VIarm/jy42gTPw==
X-Google-Smtp-Source: ABdhPJyjPDOmLDAj6OUIcPkaRSCju58kvlR9FSXWqBXpqs7gJuvRxpVVPCgrs34tyn+wVW/p1POqyw==
X-Received: by 2002:a17:90a:d086:: with SMTP id k6mr6737953pju.133.1592138382436;
        Sun, 14 Jun 2020 05:39:42 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id hi19sm9776606pjb.49.2020.06.14.05.39.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:39:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/3] mm/slub: Fix slabs_node return value when CONFIG_SLUB_DEBUG disabled
Date:   Sun, 14 Jun 2020 20:39:21 +0800
Message-Id: <20200614123923.99189-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200614123923.99189-1-songmuchun@bytedance.com>
References: <20200614123923.99189-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slabs_node() always return zero when CONFIG_SLUB_DEBUG is disabled.
But some codes determine whether slab is empty by checking the return
value of slabs_node(). As you know, the result is not correct. This
problem can be reproduce by the follow code(and boot system with the
cmdline of "slub_nomerge"):

  void *objs[32];
  struct kmem_cache *cache = kmem_cache_create("kmem-test", 128, 0,
			0, 0);

  if (cache) {
  	int i;

	/* Make a full slab */
  	for (i = 0; i < ARRAY_SIZE(objs); i++)
		objs[i] = kmem_cache_alloc(cache, GFP_KERNEL_ACCOUNT);

	/*
  	 * This really should fail because the slab cache still has
  	 * objects. But we did destroy the @cache because of zero
  	 * returned by slabs_node().
  	 */
  	kmem_cache_destroy(cache);
  }

To fix it, we can move the nr_slabs of kmem_cache_node out of the
CONFIG_SLUB_DEBUG. So we can get the corrent value returned by the
slabs_node().

With this patch applied, we will get a warning message and stack
trace in the dmesg.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slab.h |  2 +-
 mm/slub.c | 80 +++++++++++++++++++++++++++++++++------------------------------
 2 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 0b91f2a7b033..062d4542b7e2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -619,8 +619,8 @@ struct kmem_cache_node {
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
 	struct list_head partial;
-#ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
+#ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 49b5cb7da318..1a3e6a5b7287 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1070,39 +1070,14 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 	list_del(&page->slab_list);
 }
 
-/* Tracking of the number of slabs for debugging purposes */
-static inline unsigned long slabs_node(struct kmem_cache *s, int node)
+/* Tracking of the number of objects for debugging purposes */
+static inline void inc_objects_node(struct kmem_cache_node *n, int objects)
 {
-	struct kmem_cache_node *n = get_node(s, node);
-
-	return atomic_long_read(&n->nr_slabs);
+	atomic_long_add(objects, &n->total_objects);
 }
 
-static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
+static inline void dec_objects_node(struct kmem_cache_node *n, int objects)
 {
-	return atomic_long_read(&n->nr_slabs);
-}
-
-static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	/*
-	 * May be called early in order to allocate a slab for the
-	 * kmem_cache_node structure. Solve the chicken-egg
-	 * dilemma by deferring the increment of the count during
-	 * bootstrap (see early_kmem_cache_node_alloc).
-	 */
-	if (likely(n)) {
-		atomic_long_inc(&n->nr_slabs);
-		atomic_long_add(objects, &n->total_objects);
-	}
-}
-static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	atomic_long_dec(&n->nr_slabs);
 	atomic_long_sub(objects, &n->total_objects);
 }
 
@@ -1413,15 +1388,8 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 #define disable_higher_order_debug 0
 
-static inline unsigned long slabs_node(struct kmem_cache *s, int node)
-							{ return 0; }
-static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
-							{ return 0; }
-static inline void inc_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
-static inline void dec_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
-
+static inline void inc_objects_node(struct kmem_cache_node *n, int objects) {}
+static inline void dec_objects_node(struct kmem_cache_node *n, int objects) {}
 static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 			       void *freelist, void *nextfree)
 {
@@ -1429,6 +1397,42 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
+static inline unsigned long slabs_node(struct kmem_cache *s, int node)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	return atomic_long_read(&n->nr_slabs);
+}
+
+static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
+{
+	return atomic_long_read(&n->nr_slabs);
+}
+
+static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	/*
+	 * May be called early in order to allocate a slab for the
+	 * kmem_cache_node structure. Solve the chicken-egg
+	 * dilemma by deferring the increment of the count during
+	 * bootstrap (see early_kmem_cache_node_alloc).
+	 */
+	if (likely(n)) {
+		atomic_long_inc(&n->nr_slabs);
+		inc_objects_node(n, objects);
+	}
+}
+
+static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	atomic_long_dec(&n->nr_slabs);
+	dec_objects_node(n, objects);
+}
+
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
-- 
2.11.0

