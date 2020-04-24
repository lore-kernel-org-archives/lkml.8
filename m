Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C58C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B486820767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPEFeciB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgDXPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:12:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbgDXPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587741174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bG+oOpvHV7fdGOI3xpfAnUa5ETjwSHs1N5A5bl4B/qU=;
        b=LPEFeciBqF+uwpvOphb8R4jlc1OA7HZEvCm/xpdlsmXEruy31S7rN6D9psOYal6pCTI5ZZ
        XwuklUkJReuRqEQZkEvHbTIKbfMmvwlDic8wCNogC6QZPF56ajEWIovjFGsXF7YHTZze09
        el88dEw6srFJq9wS420ytc53Lv2oU/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-gN5GtHAxOB2uwdFK9C4rvg-1; Fri, 24 Apr 2020 11:12:51 -0400
X-MC-Unique: gN5GtHAxOB2uwdFK9C4rvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E86645F;
        Fri, 24 Apr 2020 15:12:49 +0000 (UTC)
Received: from llong.com (ovpn-112-86.rdu2.redhat.com [10.10.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77294600F5;
        Fri, 24 Apr 2020 15:12:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] mm, slab: Revert "extend slab/shrink to shrink all memcg caches"
Date:   Fri, 24 Apr 2020 11:12:24 -0400
Message-Id: <20200424151225.10966-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the slub shrink sysfs file is written into, the function call
sequence is as follows:

  kernfs_fop_write
    => slab_attr_store
      => shrink_store
        => kmem_cache_shrink_all

It turns out that doing a memcg cache scan in kmem_cache_shrink_all()
is redundant as the same memcg cache scan is being done in
slab_attr_store(). So revert the commit 04f768a39d55 ("mm, slab: extend
slab/shrink to shrink all memcg caches") except the documentation change
which is still valid.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab.h        |  1 -
 mm/slab_common.c | 37 -------------------------------------
 mm/slub.c        |  2 +-
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 207c83ef6e06..0937cb2ae8aa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -237,7 +237,6 @@ int __kmem_cache_shrink(struct kmem_cache *);
 void __kmemcg_cache_deactivate(struct kmem_cache *s);
 void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
 void slab_kmem_cache_release(struct kmem_cache *);
-void kmem_cache_shrink_all(struct kmem_cache *s);
 
 struct seq_file;
 struct file;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23c7500eea7d..2e367ab8c15c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -995,43 +995,6 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
 
-/**
- * kmem_cache_shrink_all - shrink a cache and all memcg caches for root cache
- * @s: The cache pointer
- */
-void kmem_cache_shrink_all(struct kmem_cache *s)
-{
-	struct kmem_cache *c;
-
-	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
-		kmem_cache_shrink(s);
-		return;
-	}
-
-	get_online_cpus();
-	get_online_mems();
-	kasan_cache_shrink(s);
-	__kmem_cache_shrink(s);
-
-	/*
-	 * We have to take the slab_mutex to protect from the memcg list
-	 * modification.
-	 */
-	mutex_lock(&slab_mutex);
-	for_each_memcg_cache(c, s) {
-		/*
-		 * Don't need to shrink deactivated memcg caches.
-		 */
-		if (s->flags & SLAB_DEACTIVATED)
-			continue;
-		kasan_cache_shrink(c);
-		__kmem_cache_shrink(c);
-	}
-	mutex_unlock(&slab_mutex);
-	put_online_mems();
-	put_online_cpus();
-}
-
 bool slab_is_available(void)
 {
 	return slab_state >= UP;
diff --git a/mm/slub.c b/mm/slub.c
index 9bf44955c4f1..183ccc364ccf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5343,7 +5343,7 @@ static ssize_t shrink_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
 	if (buf[0] == '1')
-		kmem_cache_shrink_all(s);
+		kmem_cache_shrink(s);
 	else
 		return -EINVAL;
 	return length;
-- 
2.18.1

