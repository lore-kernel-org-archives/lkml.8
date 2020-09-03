Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD0C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA722071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgICHBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:01:45 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56979 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgICHBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:01:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7n-ifu_1599116494;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7n-ifu_1599116494)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 15:01:35 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 2/4] mm/pageblock: remove false sharing in pageblock_flags
Date:   Thu,  3 Sep 2020 15:01:21 +0800
Message-Id: <1599116482-7410-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pageblock_flags is only 4 bits, so it has to share a char size
in cmpxchg when get set, the false sharing cause perf drop.

If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
the only cost is half char per pageblock, which is half char per 128MB
on x86, 4 chars in 1 GB.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/page-isolation.h  |  2 +-
 include/linux/pageblock-flags.h |  2 +-
 mm/page_alloc.c                 | 10 +++-------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 572458016331..baa2e1ecc134 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -35,7 +35,7 @@ static inline bool is_migrate_isolate(int migratetype)
 
 struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 				 int migratetype, int flags);
-void set_pageblock_migratetype(struct page *page, int migratetype);
+void set_pageblock_migratetype(struct page *page, unsigned char migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
 
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index d189441568eb..f785c9d6d68c 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -25,7 +25,7 @@ enum pageblock_bits {
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
 	 */
-	NR_PAGEBLOCK_BITS
+	NR_PAGEBLOCK_BITS = BITS_PER_BYTE
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81e96d4d9c42..3688e6b83318 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -517,19 +517,15 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, byte_bitidx;
 	unsigned char old_byte, byte;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_BYTE);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
 	byte_bitidx = bitidx / BITS_PER_BYTE;
-	bitidx &= (BITS_PER_BYTE-1);
 
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
-	mask <<= bitidx;
-	flags <<= bitidx;
-
 	byte = READ_ONCE(bitmap[byte_bitidx]);
 	for (;;) {
 		old_byte = cmpxchg(&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
@@ -539,13 +535,13 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	}
 }
 
-void set_pageblock_migratetype(struct page *page, int migratetype)
+void set_pageblock_migratetype(struct page *page, unsigned char migratetype)
 {
 	if (unlikely(page_group_by_mobility_disabled &&
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;
 
-	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
+	set_pfnblock_flags_mask(page, migratetype,
 				page_to_pfn(page), MIGRATETYPE_MASK);
 }
 
-- 
1.8.3.1

