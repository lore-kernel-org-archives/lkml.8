Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C948C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7B21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgFRKKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:10:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbgFRKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:10:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4EFDAB64;
        Thu, 18 Jun 2020 10:10:41 +0000 (UTC)
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz> <202006171039.FBDF2D7F4A@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
Date:   Thu, 18 Jun 2020 12:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006171039.FBDF2D7F4A@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/17/20 7:49 PM, Kees Cook wrote:
> On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
>> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
>> always get the cache from its page in kmem_cache_free()") to support kmemcg,
>> where per-memcg cache can be different from the root one, so we can't use
>> the kmem_cache pointer given to kmem_cache_free().
>> 
>> Prior to that commit, SLUB already had debugging check+warning that could be
>> enabled to compare the given kmem_cache pointer to one referenced by the slab
>> page where the object-to-be-freed resides. This check was moved to
>> cache_from_obj(). Later the check was also enabled for SLAB_FREELIST_HARDENED
>> configs by commit 598a0717a816 ("mm/slab: validate cache membership under
>> freelist hardening").
>> 
>> These checks and warnings can be useful especially for the debugging, which can
>> be improved. Commit 598a0717a816 changed the pr_err() with WARN_ON_ONCE() to
>> WARN_ONCE() so only the first hit is now reported, others are silent. This
>> patch changes it to WARN() so that all errors are reported.
>> 
>> It's also useful to print SLUB allocation/free tracking info for the offending
>> object, if tracking is enabled. We could export the SLUB print_tracking()
>> function and provide an empty one for SLAB, or realize that both the debugging
>> and hardening cases in cache_from_obj() are only supported by SLUB anyway. So
>> this patch moves cache_from_obj() from slab.h to separate instances in slab.c
>> and slub.c, where the SLAB version only does the kmemcg lookup and even could
> 
> Oops. I made a mistake when I applied CONFIG_SLAB_FREELIST_HARDENED
> here, I was thinking of SLAB_FREELIST_RANDOM's coverage (SLUB and SLAB),
> and I see now that I never updated CONFIG_SLAB_FREELIST_HARDENED to
> cover SLAB and SLOB.
> 
> The point being: I still want the sanity check for the SLAB case under
> hardening. This needs to stay a common function. The whole point is
> to catch corruption from the wrong kmem_cache * being associated with
> an object, and that's agnostic of slab/slub/slob.
> 
> So, I'll send a follow-up to this patch to actually do what I had
> originally intended for 598a0717a816 ("mm/slab: validate cache membership
> under freelist hardening"), which wasn't intended to be SLUB-specific.

To prvent the churn of your patch moving the cache_from_obj() back to slab.h, I
think it's best if we modify my patch. The patch below should be squashed into
the current version in mmots, with the commit log used for the whole result.

This will cause conflicts while reapplying Roman's
mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch which
can be fixed by
a) throwing away the conflicting hunks for cache_from_obj() in slab.c and slub.c
b) applying this hunk instead:

--- a/mm/slab.h
+++ b/mm/slab.h
@@ -455,12 +455,11 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 	struct kmem_cache *cachep;
 
 	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
-	    !memcg_kmem_enabled() &&
 	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
 		return s;
 
 	cachep = virt_to_cache(x);
-	if (WARN(cachep && !slab_equal_or_root(cachep, s),
+	if (WARN(cachep && cachep != s,
 		  "%s: Wrong slab cache. %s but object is from %s\n",
 		  __func__, s->name, cachep->name))
 		print_tracking(cachep, x);

The fixup patch itself:
----8<----
From b8df607d92b37e5329ce7bda62b2b364cc249893 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 18 Jun 2020 11:52:03 +0200
Subject: [PATCH] mm, slab/slub: improve error reporting and overhead of
 cache_from_obj()

The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
always get the cache from its page in kmem_cache_free()") to support
kmemcg, where per-memcg cache can be different from the root one, so we
can't use the kmem_cache pointer given to kmem_cache_free().

Prior to that commit, SLUB already had debugging check+warning that could
be enabled to compare the given kmem_cache pointer to one referenced by
the slab page where the object-to-be-freed resides.  This check was moved
to cache_from_obj().  Later the check was also enabled for
SLAB_FREELIST_HARDENED configs by commit 598a0717a816 ("mm/slab: validate
cache membership under freelist hardening").

These checks and warnings can be useful especially for the debugging,
which can be improved.  Commit 598a0717a816 changed the pr_err() with
WARN_ON_ONCE() to WARN_ONCE() so only the first hit is now reported,
others are silent.  This patch changes it to WARN() so that all errors are
reported.

It's also useful to print SLUB allocation/free tracking info for the offending
object, if tracking is enabled. Thus, export the SLUB print_tracking() function
and provide an empty one for SLAB.

For SLUB we can also benefit from the static key check in
kmem_cache_debug_flags(), but we need to move this function to slab.h and
declare the static key there.

[1] https://lore.kernel.org/r/20200608230654.828134-18-guro@fb.com

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c |  8 --------
 mm/slab.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 mm/slub.c | 38 +-------------------------------------
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 6134c4c36d4c..9350062ffc1a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3672,14 +3672,6 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
 }
 EXPORT_SYMBOL(__kmalloc_track_caller);
 
-static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
-{
-	if (memcg_kmem_enabled())
-		return virt_to_cache(x);
-	else
-		return s;
-}
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
diff --git a/mm/slab.h b/mm/slab.h
index a2696d306b62..a9f5ba9ce9a7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -275,6 +275,34 @@ static inline int cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
 }
 
+#ifdef CONFIG_SLUB_DEBUG
+#ifdef CONFIG_SLUB_DEBUG_ON
+DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
+#else
+DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
+#endif
+extern void print_tracking(struct kmem_cache *s, void *object);
+#else
+static inline void print_tracking(struct kmem_cache *s, void *object)
+{
+}
+#endif
+
+/*
+ * Returns true if any of the specified slub_debug flags is enabled for the
+ * cache. Use only for flags parsed by setup_slub_debug() as it also enables
+ * the static key.
+ */
+static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
+{
+	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
+#ifdef CONFIG_SLUB_DEBUG
+	if (static_branch_unlikely(&slub_debug_enabled))
+		return s->flags & flags;
+#endif
+	return false;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 
 /* List of all root caches. */
@@ -503,6 +531,23 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
 	memcg_uncharge_slab(page, order, s);
 }
 
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
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slub.c b/mm/slub.c
index 202fb423d195..0e635a8aa340 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -122,21 +122,6 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif
 
-/*
- * Returns true if any of the specified slub_debug flags is enabled for the
- * cache. Use only for flags parsed by setup_slub_debug() as it also enables
- * the static key.
- */
-static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
-{
-	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
-#ifdef CONFIG_SLUB_DEBUG
-	if (static_branch_unlikely(&slub_debug_enabled))
-		return s->flags & flags;
-#endif
-	return false;
-}
-
 static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
@@ -653,7 +638,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 #endif
 }
 
-static void print_tracking(struct kmem_cache *s, void *object)
+void print_tracking(struct kmem_cache *s, void *object)
 {
 	unsigned long pr_time = jiffies;
 	if (!(s->flags & SLAB_STORE_USER))
@@ -1525,10 +1510,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 {
 	return false;
 }
-
-static void print_tracking(struct kmem_cache *s, void *object)
-{
-}
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
@@ -3180,23 +3161,6 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif
 
-static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
-{
-	struct kmem_cache *cachep;
-
-	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
-	    !memcg_kmem_enabled() &&
-	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
-		return s;
-
-	cachep = virt_to_cache(x);
-	if (WARN(cachep && !slab_equal_or_root(cachep, s),
-		  "%s: Wrong slab cache. %s but object is from %s\n",
-		  __func__, s->name, cachep->name))
-		print_tracking(cachep, x);
-	return cachep;
-}
-
 void kmem_cache_free(struct kmem_cache *s, void *x)
 {
 	s = cache_from_obj(s, x);
-- 
2.27.0

