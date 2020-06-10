Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8312070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgFJQcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgFJQbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1FF89AF57;
        Wed, 10 Jun 2020 16:31:55 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vinmenon@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Date:   Wed, 10 Jun 2020 18:31:35 +0200
Message-Id: <20200610163135.17364-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610163135.17364-1-vbabka@suse.cz>
References: <20200610163135.17364-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
always get the cache from its page in kmem_cache_free()") to support kmemcg,
where per-memcg cache can be different from the root one, so we can't use
the kmem_cache pointer given to kmem_cache_free().

Prior to that commit, SLUB already had debugging check+warning that could be
enabled to compare the given kmem_cache pointer to one referenced by the slab
page where the object-to-be-freed resides. This check was moved to
cache_from_obj(). Later the check was also enabled for SLAB_FREELIST_HARDENED
configs by commit 598a0717a816 ("mm/slab: validate cache membership under
freelist hardening").

These checks and warnings can be useful especially for the debugging, which can
be improved. Commit 598a0717a816 changed the pr_err() with WARN_ON_ONCE() to
WARN_ONCE() so only the first hit is now reported, others are silent. This
patch changes it to WARN() so that all errors are reported.

It's also useful to print SLUB allocation/free tracking info for the offending
object, if tracking is enabled. We could export the SLUB print_tracking()
function and provide an empty one for SLAB, or realize that both the debugging
and hardening cases in cache_from_obj() are only supported by SLUB anyway. So
this patch moves cache_from_obj() from slab.h to separate instances in slab.c
and slub.c, where the SLAB version only does the kmemcg lookup and even could
be completely removed once the kmemcg rework [1] is merged. The SLUB version
can thus easily use the print_tracking() function. It can also use the
kmem_cache_debug_flags() static key check for improved performance in kernels
without the hardening and with debugging not enabled on boot.

[1] https://lore.kernel.org/r/20200608230654.828134-18-guro@fb.com

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c |  8 ++++++++
 mm/slab.h | 23 -----------------------
 mm/slub.c | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..6134c4c36d4c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3672,6 +3672,14 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
 }
 EXPORT_SYMBOL(__kmalloc_track_caller);
 
+static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
+{
+	if (memcg_kmem_enabled())
+		return virt_to_cache(x);
+	else
+		return s;
+}
+
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
diff --git a/mm/slab.h b/mm/slab.h
index 815e4e9a94cd..c0c4244f75da 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -503,29 +503,6 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
 	memcg_uncharge_slab(page, order, s);
 }
 
-static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
-{
-	struct kmem_cache *cachep;
-
-	/*
-	 * When kmemcg is not being used, both assignments should return the
-	 * same value. but we don't want to pay the assignment price in that
-	 * case. If it is not compiled in, the compiler should be smart enough
-	 * to not do even the assignment. In that case, slab_equal_or_root
-	 * will also be a constant.
-	 */
-	if (!memcg_kmem_enabled() &&
-	    !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
-	    !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
-		return s;
-
-	cachep = virt_to_cache(x);
-	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
-		  "%s: Wrong slab cache. %s but object is from %s\n",
-		  __func__, s->name, cachep->name);
-	return cachep;
-}
-
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slub.c b/mm/slub.c
index efb08f2e9c66..f7a1d8537674 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1524,6 +1524,10 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 {
 	return false;
 }
+
+static void print_tracking(struct kmem_cache *s, void *object)
+{
+}
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
@@ -3175,6 +3179,23 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif
 
+static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
+{
+	struct kmem_cache *cachep;
+
+	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
+	    !memcg_kmem_enabled() &&
+	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
+		return s;
+
+	cachep = virt_to_cache(x);
+	if (WARN(cachep && !slab_equal_or_root(cachep, s),
+		  "%s: Wrong slab cache. %s but object is from %s\n",
+		  __func__, s->name, cachep->name))
+		print_tracking(cachep, x);
+	return cachep;
+}
+
 void kmem_cache_free(struct kmem_cache *s, void *x)
 {
 	s = cache_from_obj(s, x);
-- 
2.26.2

