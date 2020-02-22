Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7BC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E960A208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBVJZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 04:25:14 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47084 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgBVJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 04:25:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TqatCjt_1582363499;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TqatCjt_1582363499)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Feb 2020 17:25:06 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, Roman Gushchin <guro@fb.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: improve count_partial() for CONFIG_SLUB_CPU_PARTIAL
Date:   Sat, 22 Feb 2020 17:24:28 +0800
Message-Id: <20200222092428.99488-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cloud server scenario, reading "/proc/slabinfo" can possibily
block the slab allocation on another CPU for a while, 200ms in extreme
cases. If the slab object is to carry network packet, targeting the
far-end disk array, it causes block IO jitter issues.

This is because the list_lock, which protecting the node partial list,
is taken when couting the free objects resident in that list. It introduces
locking contention when the page(s) is moved between CPU and node partial
lists in allocation path on another CPU.

We also observed that in this scenario, CONFIG_SLUB_CPU_PARTIAL is turned
on by default, and count_partial() is useless because the returned number
is far from the reality.

Therefore, we can simply return 0, then nr_free is also 0, and eventually
active_objects == total_objects. We do not introduce any regression, and
it's preferable to show the unrealistic uniform 100% slab utilization
rather than some very high but incorrect value.

Co-developed-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 17dc00e..d5b7230 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2411,14 +2411,16 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct page *))
 {
-	unsigned long flags;
 	unsigned long x = 0;
+#ifndef CONFIG_SLUB_CPU_PARTIAL
+	unsigned long flags;
 	struct page *page;
 
 	spin_lock_irqsave(&n->list_lock, flags);
 	list_for_each_entry(page, &n->partial, slab_list)
 		x += get_count(page);
 	spin_unlock_irqrestore(&n->list_lock, flags);
+#endif
 	return x;
 }
 #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
-- 
1.8.3.1

