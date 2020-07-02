Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10602C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3F6208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHVI+Z2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgGBP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgGBP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:28:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21780C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:28:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u9so7834164pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f6NHiKBOJxQx2yu25TfleraIEvN0rvdlanwLkWkQo5A=;
        b=sHVI+Z2+QnOPqFlk3cV7wUqBpsuT8U4d+eJmFckHcxG7gqqQkN+g7rfCTrAWhH7zNE
         NvrXfIlEHszrhIITJ9+pPVwQqvE2YB8HeAb5tFoHjVkEMaqRYA20kfE7+gyS6W5lzmuc
         YsuZ2NpjIhjzaXTIf+J4IR/TKAhwbKdV0R7WNx2zWAnIH+S7TuyUbnR6pQHYuT+T5G2T
         gWpdWk20+PiJFXXgXFqQn1nXjVzBONJN00cdX30q+cO0KiRnf72jqzZx45Ic6JBfS2wf
         Evu8EseZLptk03ZJbPI2HN8JhJgxb44mkjn+oZ5x2rf+DCWhEPdsk69097DF0w3fQ0Q7
         hkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f6NHiKBOJxQx2yu25TfleraIEvN0rvdlanwLkWkQo5A=;
        b=JkxUHzGTP92EOyzn+SNQIDc7LLPH+Y0EGnHxWVSmEJ+Nj+7p9X2FmV5quqE150dxng
         UFXyagOkTO++J7Tfy7XRF+Vhu0ke40OthAFkg5ySfmQPvlODxEXTSg+QIU1cs1mnL58/
         5Aft2AjnYC9DhepCylqUZVwaufBLh24TU4KUEalXCv5AZm+3Slqbiy0dfKJI8eoaHYCa
         4NWBJLcf1fA0azz1zQXBXRyaGSiAw3LfU9KaiM1O8Z9ZyzTv/z71hMRc+ZWpsHWHR1qw
         WvP31ulrj/oFm8kugR3T1vzXA8g7HUW7bOUp7bJyMSJNbc3PgLHs7NKiPFKT0raJl3+b
         U2Vg==
X-Gm-Message-State: AOAM532WXQ3ZokEK8qjGROTYWNyE0d3zua/DX2HwlT1NTSdHAfd8pAqH
        CZ1+MEPbBiV+x8sPvTiH0rE=
X-Google-Smtp-Source: ABdhPJxfhDWpMb0DIFZ7cnoKC1zFDSgfvqqwtdrZliYAbrZoOBhClp2cLdpKYFc9Nnhr40pnaonwCw==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr27861805plo.57.1593703693653;
        Thu, 02 Jul 2020 08:28:13 -0700 (PDT)
Received: from localhost ([144.34.187.180])
        by smtp.gmail.com with ESMTPSA id s194sm9248546pgs.24.2020.07.02.08.28.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 08:28:13 -0700 (PDT)
Date:   Thu, 2 Jul 2020 15:27:59 +0000
From:   Long Li <lonuxli.64@gmail.com>
To:     willy@infradead.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages in
 kmalloc_order
Message-ID: <20200702152759.GA32931@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc cannot allocate memory from HIGHMEM.  Allocating large amounts
of memory currently bypasses the check and will simply leak the memory
when page_address() returns NULL.  To fix this, factor the
GFP_SLAB_BUG_MASK check out of slab & slub, and call it from
kmalloc_order() as well. In order to make the code clear, the warning
message is put in one place.

Signed-off-by: Long Li <lonuxli.64@gmail.com>
---
changes in V4:
-Change the check function name to kmalloc_check_flags()
-Put the flags check into the kmalloc_check_flags() 

changes in V3:
-Put the warning message in one place
-updage the change log to be clear

 mm/slab.c        |  8 +-------
 mm/slab.h        |  1 +
 mm/slab_common.c | 18 +++++++++++++++++-
 mm/slub.c        |  8 +-------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ac7a223d9ac3..755f33f96f04 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2573,13 +2573,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
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
+	flags = kmalloc_check_flags(flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slab.h b/mm/slab.h
index a06f3313e4a0..48df5660764c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -90,6 +90,7 @@ void create_kmalloc_caches(slab_flags_t);
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 #endif
 
+gfp_t kmalloc_check_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index a143a8c8f874..9184e4575d6d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -26,6 +26,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/kmem.h>
 
+#include "internal.h"
+
 #include "slab.h"
 
 enum slab_state slab_state;
@@ -805,6 +807,20 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 }
 #endif /* !CONFIG_SLOB */
 
+gfp_t kmalloc_check_flags(gfp_t flags)
+{
+	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
+		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
+
+		flags &= ~GFP_SLAB_BUG_MASK;
+		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+				invalid_mask, &invalid_mask, flags, &flags);
+		dump_stack();
+	}
+
+	return flags;
+}
+
 /*
  * To avoid unnecessary overhead, we pass through large allocation requests
  * directly to the page allocator. We use __GFP_COMP, because we will need to
@@ -815,7 +831,7 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	void *ret = NULL;
 	struct page *page;
 
-	flags |= __GFP_COMP;
+	flags = kmalloc_check_flags(flags) | __GFP_COMP;
 	page = alloc_pages(flags, order);
 	if (likely(page)) {
 		ret = page_address(page);
diff --git a/mm/slub.c b/mm/slub.c
index 62d2de56549e..8e787767850f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1817,13 +1817,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = kmalloc_check_flags(flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-- 
2.17.1

