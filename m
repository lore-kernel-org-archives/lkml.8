Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17FA2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgFJQcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgFJQby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15E47AF4F;
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
Subject: [PATCH 7/9] mm, slub: introduce kmem_cache_debug_flags()
Date:   Wed, 10 Jun 2020 18:31:33 +0200
Message-Id: <20200610163135.17364-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610163135.17364-1-vbabka@suse.cz>
References: <20200610163135.17364-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few places that call kmem_cache_debug(s) (which tests if any of debug
flags are enabled for a cache) immediatelly followed by a test for a specific
flag. The compiler can probably eliminate the extra check, but we can make the
code nicer by introducing kmem_cache_debug_flags() that works like
kmem_cache_debug() (including the static key check) but tests for specifig
flag(s). The next patches will add more users.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 24d3e5f832aa..c8e8b4ae2451 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -122,18 +122,28 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif
 
-static inline int kmem_cache_debug(struct kmem_cache *s)
+/*
+ * Returns true if any of the specified slub_debug flags is enabled for the
+ * cache. Use only for flags parsed by setup_slub_debug() as it also enables
+ * the static key.
+ */
+static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
 #ifdef CONFIG_SLUB_DEBUG
 	if (static_branch_unlikely(&slub_debug_enabled))
-		return s->flags & SLAB_DEBUG_FLAGS;
+		return s->flags & flags;
 #endif
 	return 0;
 }
 
+static inline int kmem_cache_debug(struct kmem_cache *s)
+{
+	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
+}
+
 void *fixup_red_left(struct kmem_cache *s, void *p)
 {
-	if (kmem_cache_debug(s) && s->flags & SLAB_RED_ZONE)
+	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
 		p += s->red_left_pad;
 
 	return p;
@@ -4076,7 +4086,7 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 	offset = (ptr - page_address(page)) % s->size;
 
 	/* Adjust for redzone and reject if within the redzone. */
-	if (kmem_cache_debug(s) && s->flags & SLAB_RED_ZONE) {
+	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE)) {
 		if (offset < s->red_left_pad)
 			usercopy_abort("SLUB object in left red zone",
 				       s->name, to_user, offset, n);
-- 
2.26.2

