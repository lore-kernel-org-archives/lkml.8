Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E872FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CED206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="zEhIacWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgFNGje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:39:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81934C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:39:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so6186295pgn.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBuxpUA3UgXQeJ6yjt0LyKTJBSZPG5D7qi17zQVgy78=;
        b=zEhIacWz/ZuRcfT9j2C+weG+5nGXWYqbYPGmpkBacnxp/9N3Pt2pMxp8/FS1Zn4gPk
         QIs7ZHjRX4UOEhWFJy9aQ2+uhmSD6h/sPZnhlrq43O/1Bok+/BCNgUGeZln0gPPqIkQN
         eiH/NBD9vaXwWm243zf34rX0XxsJi7ynxaXz9mac0YAL2Ir6CEy4NID+sL6QMjvmJx0r
         +3dO49QF0hMac8ZZqiNEb6X9S5RCtwAik3HSHogcyD/yqyh0XGTtkzWmZCL5IjsHgOz8
         XjuPrrcca1qVJr57M6+qyk710FS5GwYNeL5mFGmCtPK6eagTkT+7AVcePY+hdRa629Z6
         nYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBuxpUA3UgXQeJ6yjt0LyKTJBSZPG5D7qi17zQVgy78=;
        b=o7Z63F4ETK30+X5PzH1MuuGYnEwdUCTUM4QUkGjTGPRZCWoeaM7Ior240grwpIXKZT
         2FDwJbP9hhmgh7jB8h5osUJ8tyLmdKQn5HNmdL4DdePwnucEBp7EmUeAWg/sUImvmycg
         eGfwRrHV3iJw8KWRWkWdO4spoALmSBmHso4rl00ZQ8hvzJ1Ie+1L4csP3ovSSZFa/lLG
         1/Wljf/J3yJrKPYnkxPTOLPCrqnKFnbssok0zI/TdRoVJWnwoeM3XxLinAa5myvrsQjD
         pwGXOMOUeusFQp8G7YXQa5gASPc2Yne+ZkCdar+BOALe8BdjwO/mUPfHy9rA+8gpxuEG
         FYyA==
X-Gm-Message-State: AOAM533DzXm3dq8fDuz0S7LeFZvlDd/fFQA+a7PdzUjfPEjdaxzVx0VH
        BkQJEHf2WY5UkVXI/DQvjJ2N4g==
X-Google-Smtp-Source: ABdhPJxfP1CRHnOtjXV37HOXDbESM8vh3+kuv+xWhizYvtbR3j7CtYbBNicmPe4jRaQ3z7Bb5Cs0Sw==
X-Received: by 2002:a62:7a89:: with SMTP id v131mr18257746pfc.38.1592116772902;
        Sat, 13 Jun 2020 23:39:32 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id 191sm10453067pfy.161.2020.06.13.23.39.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2020 23:39:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/slab: Add a __GFP_ACCOUNT GFP flag check for slab allocation
Date:   Sun, 14 Jun 2020 14:38:58 +0800
Message-Id: <20200614063858.85118-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kmem_cache is initialized with SLAB_ACCOUNT slab flag, we must
not call kmem_cache_alloc with __GFP_ACCOUNT GFP flag. In this case,
we can be accounted to kmemcg twice. This is not correct. So we add a
__GFP_ACCOUNT GFP flag check for slab allocation.

We also introduce a new helper named fixup_gfp_flags to do that check.
We can reuse the fixup_gfp_flags for SLAB/SLUB.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slab.c | 10 +---------
 mm/slab.h | 21 +++++++++++++++++++++
 mm/slub.c | 10 +---------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..6e0110bef2d6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -126,8 +126,6 @@
 
 #include <trace/events/kmem.h>
 
-#include	"internal.h"
-
 #include	"slab.h"
 
 /*
@@ -2579,13 +2577,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = fixup_gfp_flags(cachep, flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slab.h b/mm/slab.h
index 815e4e9a94cd..0b91f2a7b033 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -109,6 +109,7 @@ struct memcg_cache_params {
 #include <linux/kmemleak.h>
 #include <linux/random.h>
 #include <linux/sched/mm.h>
+#include "internal.h"
 
 /*
  * State of the slab allocator.
@@ -627,6 +628,26 @@ struct kmem_cache_node {
 
 };
 
+static inline gfp_t fixup_gfp_flags(struct kmem_cache *s, gfp_t flags)
+{
+	gfp_t invalid_mask = 0;
+
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		invalid_mask |= flags & GFP_SLAB_BUG_MASK;
+
+	if (unlikely(flags & __GFP_ACCOUNT && s->flags & SLAB_ACCOUNT))
+		invalid_mask |= __GFP_ACCOUNT;
+
+	if (unlikely(invalid_mask)) {
+		flags &= ~invalid_mask;
+		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+				invalid_mask, &invalid_mask, flags, &flags);
+		dump_stack();
+	}
+
+	return flags;
+}
+
 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 {
 	return s->node[node];
diff --git a/mm/slub.c b/mm/slub.c
index b8f798b50d44..49b5cb7da318 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -37,8 +37,6 @@
 
 #include <trace/events/kmem.h>
 
-#include "internal.h"
-
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
@@ -1745,13 +1743,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = fixup_gfp_flags(s, flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-- 
2.11.0

