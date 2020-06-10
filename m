Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74C72070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgFJQcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:32:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbgFJQbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B35BAF4D;
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
Subject: [PATCH 6/9] mm, slub: introduce static key for slub_debug()
Date:   Wed, 10 Jun 2020 18:31:32 +0200
Message-Id: <20200610163135.17364-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610163135.17364-1-vbabka@suse.cz>
References: <20200610163135.17364-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One advantage of CONFIG_SLUB_DEBUG is that a generic distro kernel can be built
with the option enabled, but it's inactive until simply enabled on boot,
without rebuilding the kernel. With a static key, we can further eliminate the
overhead of checking whether a cache has a particular debug flag enabled if we
know that there are no such caches (slub_debug was not enabled during boot). We
use the same mechanism also for e.g.  page_owner, debug_pagealloc or kmemcg
functionality.

This patch introduces the static key and makes the general check for per-cache
debug flags kmem_cache_debug() use it. This benefits several call sites,
including (slow path but still rather frequent) __slab_free(). The next patches
will add more uses.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8dd2925448ae..24d3e5f832aa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -114,13 +114,21 @@
  * 			the fast path and disables lockless freelists.
  */
 
+#ifdef CONFIG_SLUB_DEBUG
+#ifdef CONFIG_SLUB_DEBUG_ON
+DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
+#else
+DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
+#endif
+#endif
+
 static inline int kmem_cache_debug(struct kmem_cache *s)
 {
 #ifdef CONFIG_SLUB_DEBUG
-	return unlikely(s->flags & SLAB_DEBUG_FLAGS);
-#else
-	return 0;
+	if (static_branch_unlikely(&slub_debug_enabled))
+		return s->flags & SLAB_DEBUG_FLAGS;
 #endif
+	return 0;
 }
 
 void *fixup_red_left(struct kmem_cache *s, void *p)
@@ -1389,6 +1397,8 @@ static int __init setup_slub_debug(char *str)
 		slub_debug_string = saved_str;
 	}
 out:
+	if (slub_debug != 0 || slub_debug_string)
+		static_branch_enable(&slub_debug_enabled);
 	if ((static_branch_unlikely(&init_on_alloc) ||
 	     static_branch_unlikely(&init_on_free)) &&
 	    (slub_debug & SLAB_POISON))
-- 
2.26.2

