Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC041C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA5D24181
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzG34s6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgFTSrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:47:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbgFTSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592678861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mClg+dw3ex3SxKOKAQfa7c9Gaag31kwGFLnQSg16We4=;
        b=GzG34s6gY692Rgl9kT7XxlgBWanlLqRHnyVnFtk5SMJ279A3HqahZVfuLtYQA0W4SA8g8A
        gsjiRSjjhnmO9iLQf8MIkBSXTO/qIyc5NVAyk0WCSki4UUNKKxzqXMq1ORZ9lR4Cib4WF7
        K1/dJFKXaK2jajqyhskgNdd8Vpey5UE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-i8PliEcoOT2WuuoRnpFgXA-1; Sat, 20 Jun 2020 14:47:39 -0400
X-MC-Unique: i8PliEcoOT2WuuoRnpFgXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE66F107ACCD;
        Sat, 20 Jun 2020 18:47:36 +0000 (UTC)
Received: from llong.com (ovpn-112-81.rdu2.redhat.com [10.10.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FB8A19C4F;
        Sat, 20 Jun 2020 18:47:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm, slab: Fix sign conversion problem in memcg_uncharge_slab()
Date:   Sat, 20 Jun 2020 14:47:19 -0400
Message-Id: <20200620184719.10994-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that running the LTP test on a PowerPC system could produce
erroneous values in /proc/meminfo, like:

  MemTotal:       531915072 kB
  MemFree:        507962176 kB
  MemAvailable:   1100020596352 kB

Using bisection, the problem is tracked down to commit 9c315e4d7d8c
("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").

In memcg_uncharge_slab() with a "int order" argument:

  unsigned int nr_pages = 1 << order;
    :
  mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);

The mod_lruvec_state() function will eventually call the
__mod_zone_page_state() which accepts a long argument.  Depending on
the compiler and how inlining is done, "-nr_pages" may be treated as
a negative number or a very large positive number. Apparently, it was
treated as a large positive number in that PowerPC system leading to
incorrect stat counts. This problem hasn't been seen in x86-64 yet,
perhaps the gcc compiler there has some slight difference in behavior.

It is fixed by making nr_pages a signed value. For consistency, a
similar change is applied to memcg_charge_slab() as well.

Fixes: 9c315e4d7d8c ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 207c83ef6e06..74f7e09a7cfd 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -348,7 +348,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 					     gfp_t gfp, int order,
 					     struct kmem_cache *s)
 {
-	unsigned int nr_pages = 1 << order;
+	int nr_pages = 1 << order;
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 	int ret;
@@ -388,7 +388,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 						struct kmem_cache *s)
 {
-	unsigned int nr_pages = 1 << order;
+	int nr_pages = 1 << order;
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-- 
2.18.1

