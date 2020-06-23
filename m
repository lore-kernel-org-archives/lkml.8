Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE99CC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C6E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbgFWMmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:42:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35067 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732589AbgFWMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:42:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U0WDmIY_1592916132;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0WDmIY_1592916132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 20:42:12 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mgorman@suse.de, akpm@linux-foundation.org,
        richard.weiyang@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm/page_alloc.c: simplify pageblock bitmap access
Date:   Tue, 23 Jun 2020 20:42:00 +0800
Message-Id: <20200623124201.8199-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
References: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From commit e58469bafd05 ("mm: page_alloc: use word-based accesses for
get/set pageblock bitmaps"), pageblock bitmap is accessed with
word-based access. This operation could be simplified a little.

Intuitively, if we want to get a bit range [start_idx, end_idx] in a
word, we can do like this:

    mask = (1 << (end_bitidx - start_bitidx + 1)) - 1;
    ret = (word >> start_idx) & mask;

And also if we want to set a bit range [start_idx, end_idx] with flags, we
can do the same by just shift start_bitidx.

By doing so we reduce some instructions for these two helper functions:

                                Before   Patched
    set_pfnblock_flags_mask     209      198(-5%)
    get_pfnblock_flags_mask     101      87(-13%)

Since the syntax is changed a little, we need to check the whole 4-bit
migrate_type instead of part of it.

CC: Mel Gorman <mgorman@suse.de>
Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/pageblock-flags.h | 22 +++++++---------------
 mm/page_alloc.c                 | 13 ++++++-------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index c066fec5b74b..6556e4474409 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -66,25 +66,17 @@ void set_pfnblock_flags_mask(struct page *page,
 				unsigned long mask);
 
 /* Declarations for getting and setting flags. See mm/page_alloc.c */
-#define get_pageblock_flags_group(page, start_bitidx, end_bitidx) \
-	get_pfnblock_flags_mask(page, page_to_pfn(page),		\
-			end_bitidx,					\
-			(1 << (end_bitidx - start_bitidx + 1)) - 1)
-#define set_pageblock_flags_group(page, flags, start_bitidx, end_bitidx) \
-	set_pfnblock_flags_mask(page, flags, page_to_pfn(page),		\
-			end_bitidx,					\
-			(1 << (end_bitidx - start_bitidx + 1)) - 1)
-
 #ifdef CONFIG_COMPACTION
 #define get_pageblock_skip(page) \
-			get_pageblock_flags_group(page, PB_migrate_skip,     \
-							PB_migrate_skip)
+	get_pfnblock_flags_mask(page, page_to_pfn(page),	\
+			PB_migrate_skip, (1 << (PB_migrate_skip)))
 #define clear_pageblock_skip(page) \
-			set_pageblock_flags_group(page, 0, PB_migrate_skip,  \
-							PB_migrate_skip)
+	set_pfnblock_flags_mask(page, 0, page_to_pfn(page),	\
+			PB_migrate_skip, (1 << PB_migrate_skip))
 #define set_pageblock_skip(page) \
-			set_pageblock_flags_group(page, 1, PB_migrate_skip,  \
-							PB_migrate_skip)
+	set_pfnblock_flags_mask(page, (1 << PB_migrate_skip),	\
+			page_to_pfn(page),			\
+			PB_migrate_skip, (1 << PB_migrate_skip))
 #else
 static inline bool get_pageblock_skip(struct page *page)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index efc2c355ac52..9da416eec284 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -489,8 +489,7 @@ static __always_inline unsigned long __get_pfnblock_flags_mask(struct page *page
 	bitidx &= (BITS_PER_LONG-1);
 
 	word = bitmap[word_bitidx];
-	bitidx += end_bitidx;
-	return (word >> (BITS_PER_LONG - bitidx - 1)) & mask;
+	return (word >> bitidx) & mask;
 }
 
 unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
@@ -532,9 +531,8 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
-	bitidx += end_bitidx;
-	mask <<= (BITS_PER_LONG - bitidx - 1);
-	flags <<= (BITS_PER_LONG - bitidx - 1);
+	mask <<= bitidx;
+	flags <<= bitidx;
 
 	word = READ_ONCE(bitmap[word_bitidx]);
 	for (;;) {
@@ -551,8 +549,9 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;
 
-	set_pageblock_flags_group(page, (unsigned long)migratetype,
-					PB_migrate, PB_migrate_end);
+	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
+				page_to_pfn(page), PB_migrate_end,
+				MIGRATETYPE_MASK);
 }
 
 #ifdef CONFIG_DEBUG_VM
-- 
2.20.1 (Apple Git-117)

