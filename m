Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA85C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587FD20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgFJQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:31:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgFJQbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C287CAF24;
        Wed, 10 Jun 2020 16:31:53 +0000 (UTC)
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
Subject: [PATCH 3/9] mm, slub: remove runtime allocation order changes
Date:   Wed, 10 Jun 2020 18:31:29 +0200
Message-Id: <20200610163135.17364-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610163135.17364-1-vbabka@suse.cz>
References: <20200610163135.17364-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB allows runtime changing of page allocation order by writing into the
/sys/kernel/slab/<cache>/order file. Jann has reported [1] that this interface
allows the order to be set too small, leading to crashes.

While it's possible to fix the immediate issue, closer inspection reveals
potential races. Storing the new order calls calculate_sizes() which
non-atomically updates a lot of kmem_cache fields while the cache is still in
use. Unexpected behavior might occur even if the fields are set to the same
value as they were.

This could be fixed by splitting out the part of calculate_sizes() that depends
on forced_order, so that we only update kmem_cache.oo field. This could still
race with init_cache_random_seq(), shuffle_freelist(), allocate_slab(). Perhaps
it's possible to audit and e.g. add some READ_ONCE/WRITE_ONCE accesses, it
might be easier just to remove the runtime order changes, which is what this
patch does. If there are valid usecases for per-cache order setting, we could
e.g. extend the boot parameters to do that.

[1] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/slub.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e254164d6cae..c5f3f2424392 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5111,28 +5111,11 @@ static ssize_t objs_per_slab_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(objs_per_slab);
 
-static ssize_t order_store(struct kmem_cache *s,
-				const char *buf, size_t length)
-{
-	unsigned int order;
-	int err;
-
-	err = kstrtouint(buf, 10, &order);
-	if (err)
-		return err;
-
-	if (order > slub_max_order || order < slub_min_order)
-		return -EINVAL;
-
-	calculate_sizes(s, order);
-	return length;
-}
-
 static ssize_t order_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%u\n", oo_order(s->oo));
 }
-SLAB_ATTR(order);
+SLAB_ATTR_RO(order);
 
 static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
 {
-- 
2.26.2

