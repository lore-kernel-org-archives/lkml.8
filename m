Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84658C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE7821789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSpKhHkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFQTx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFQTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:53:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E670C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:53:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n9so1437131plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2AA+B7WTCHPufkuKtegBkYj399ncB9pbwg+pVpWalo=;
        b=QSpKhHkYTeIsAvtrVkrVdqH5eme/TWjK6rMA3wN22Mjyssib9eqwUoVqGENyNW7ZHV
         KF58wNwC2Pk9H2hdY1k3IlNN1R28CI64UcAxaQENlKNhf2JIi60gzWSJAVvijdIBnsPj
         +okd/zaOtaETb5fQvFLe6SfmoK8eOvH/PB3xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2AA+B7WTCHPufkuKtegBkYj399ncB9pbwg+pVpWalo=;
        b=laF5kqpiAhesqm0k2HTGx7ZH02K0eXkVQCoYRbglmn/g7szRPeqIlAFYkjMFnDTDWo
         ckJ21iUqTFgR/Ah1Twakl0NpIWGl5mlSg+16lM/NfNr+5L9BGF37RNwc45TMCaQzH1Cu
         RwNVU/F3cYtOhNtuYMqCp5TpuG/n7yjb+EcyOQi/o4DYY/0XcqIBJGc4+lC3JxbLJcD8
         LrA8t5EInWu0oEpVrPFhBPtWtvB0McQ0MrVSKmhjWHqGHXyS4oX2j9uUT1VKapveDL+g
         r91dSTsS3qRxvQM0MGUGSZcZq8cDePsUi4IZlOXP4cMIvZ/zxXVFIcgKDAqnSp1ms5Ng
         0zkg==
X-Gm-Message-State: AOAM5325Ps3bfBkmJ9lhZf3kfsYrxaHOfhPgCPngO//Lkz/0BAiKy5Vf
        2yGdIWfXg3Ebdn9lq2+/31NMoQ==
X-Google-Smtp-Source: ABdhPJxG0haUmkR0G3K6PcNOeyCXNYo8ctIyWAWnsUhurpfESipBK8kIZoTj1Un2WF6jq1Xb+4/24Q==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr661937pjo.94.1592423634696;
        Wed, 17 Jun 2020 12:53:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i22sm627663pfo.92.2020.06.17.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:53:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include SLAB and SLOB
Date:   Wed, 17 Jun 2020 12:53:48 -0700
Message-Id: <20200617195349.3471794-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617195349.3471794-1-keescook@chromium.org>
References: <20200617195349.3471794-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include SLAB and SLOB caches when performing kmem_cache pointer
verification. A defense against such corruption[1] should be applied
to all the allocators. With this added, the "SLAB_FREE_CROSS" and
"SLAB_FREE_PAGE" LKDTM tests now pass on SLAB:

  lkdtm: Performing direct entry SLAB_FREE_CROSS
  lkdtm: Attempting cross-cache slab free ...
  ------------[ cut here ]------------
  cache_from_obj: Wrong slab cache. lkdtm-heap-b but object is from lkdtm-heap-a
  WARNING: CPU: 2 PID: 2195 at mm/slab.h:530 kmem_cache_free+0x8d/0x1d0
  ...
  lkdtm: Performing direct entry SLAB_FREE_PAGE
  lkdtm: Attempting non-Slab slab free ...
  ------------[ cut here ]------------
  virt_to_cache: Object is not a Slab page!
  WARNING: CPU: 1 PID: 2202 at mm/slab.h:489 kmem_cache_free+0x196/0x1d0

Additionally clean up neighboring Kconfig entries for clarity,
readability, and redundant option removal.

[1] https://github.com/ThomasKing2014/slides/raw/master/Building%20universal%20Android%20rooting%20with%20a%20type%20confusion%20vulnerability.pdf

Fixes: 598a0717a816 ("mm/slab: validate cache membership under freelist hardening")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Kconfig |  8 ++++----
 mm/slab.c    |  8 --------
 mm/slab.h    | 31 +++++++++++++++++++++++++++++++
 mm/slub.c    | 25 +------------------------
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..b5e616e5fd2f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1885,9 +1885,8 @@ config SLAB_MERGE_DEFAULT
 	  command line.
 
 config SLAB_FREELIST_RANDOM
-	default n
+	bool "Randomize slab freelist"
 	depends on SLAB || SLUB
-	bool "SLAB freelist randomization"
 	help
 	  Randomizes the freelist order used on creating new pages. This
 	  security feature reduces the predictability of the kernel slab
@@ -1895,12 +1894,13 @@ config SLAB_FREELIST_RANDOM
 
 config SLAB_FREELIST_HARDENED
 	bool "Harden slab freelist metadata"
-	depends on SLUB
 	help
 	  Many kernel heap attacks try to target slab cache metadata and
 	  other infrastructure. This options makes minor performance
 	  sacrifices to harden the kernel slab allocator against common
-	  freelist exploit methods.
+	  freelist exploit methods. Some slab implementations have more
+	  sanity-checking than others. This option is most effective with
+	  CONFIG_SLUB.
 
 config SHUFFLE_PAGE_ALLOCATOR
 	bool "Page allocator randomization"
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
index a2696d306b62..090d8b8e7bf8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -467,6 +467,20 @@ static inline void memcg_link_cache(struct kmem_cache *s,
 
 #endif /* CONFIG_MEMCG_KMEM */
 
+#ifdef CONFIG_SLUB_DEBUG
+extern inline int kmem_cache_debug_flags(struct kmem_cache *s,
+					 slab_flags_t flags);
+extern inline void print_tracking(struct kmem_cache *s, void *object);
+#else
+static inline int kmem_cache_debug_flags(struct kmem_cache *s,
+					 slab_flags_t flags)
+{
+	return 0;
+}
+static inline void print_tracking(struct kmem_cache *s, void *object)
+{ }
+#endif
+
 static inline struct kmem_cache *virt_to_cache(const void *obj)
 {
 	struct page *page;
@@ -503,6 +517,23 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
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
index f7a1d8537674..cd4891448db4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -120,7 +120,6 @@ DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
 #else
 DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
-#endif
 
 /*
  * Returns true if any of the specified slub_debug flags is enabled for the
@@ -129,12 +128,11 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
  */
 static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
-#ifdef CONFIG_SLUB_DEBUG
 	if (static_branch_unlikely(&slub_debug_enabled))
 		return s->flags & flags;
-#endif
 	return 0;
 }
+#endif
 
 static inline int kmem_cache_debug(struct kmem_cache *s)
 {
@@ -1524,10 +1522,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 {
 	return false;
 }
-
-static void print_tracking(struct kmem_cache *s, void *object)
-{
-}
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
@@ -3179,23 +3173,6 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
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
2.25.1

